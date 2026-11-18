# smart-house

## Onboarding a fresh install

Steps that still happen in the HA UI after deploying to a host with no existing `/var/lib/hass`:

1. Create the user account
2. Set the location
3. Create accounts for other household members
4. Add Apple TV
5. Add System Monitor, then enable these entities (the rest stay disabled):
   - Disk usage
   - Last boot
   - Load (1 min)
   - Memory usage
   - Processor use
   - Processor temperature
   - Swap usage
   - CPU pressure (some, 60s average)
6. Approve the discovered WLED device
7. Configure the mobile app
8. Plug in the zigbee USB device and register devices
9. Approve the discovered Piper (Wyoming Protocol) device. Then pick Piper as the text-to-speech engine under Settings → Voice assistants.


Reolink camera

```python
import asyncio
from reolink_aio.api import Host

CAMERA_IP = # Replace with your camera's IP
NEW_PASSWORD = # Letters & numbers only, max 31 chars

async def setup_camera():
    # Connect with blank password over port 9000
    host = Host(CAMERA_IP, "admin", "", port=9000)
    await host.get_host_data()

    # 1. Send the ModifyUser command directly to set the initial admin password
    body = [
        {
            "cmd": "ModifyUser",
            "action": 0,
            "param": {
                "User": {
                    "userName": "admin",
                    "oldPassword": "",
                    "newPassword": NEW_PASSWORD,
                }
            },
        }
    ]
    response = await host.send(body)
    print("Password update response:", response)

    await host.logout()

    # 2. Reconnect with the new password to enable RTSP and ONVIF ports
    host = Host(CAMERA_IP, "admin", NEW_PASSWORD, port=9000)
    await host.get_host_data()
    await host.set_net_port(enable_onvif=True, enable_rtsp=True)
    print("RTSP (554) and ONVIF (8000) enabled.")

    await host.logout()

asyncio.run(setup_camera())
```