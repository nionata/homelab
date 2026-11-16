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
