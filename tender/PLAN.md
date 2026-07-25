
## Plan

1. Decide on Legacy API or GTFS? Ideally we won't need to create an api key. The legacy API has a public key `MW9S-E7SL-26DU-VV8V`.
2. Is there a rust crate that wraps the api? if not, make a bart-rs crate to do so. Do it in ~/Developer/bart. We can start with minimal API surface.
3. As part of the bart-rs crate, have a cli that exercises the lib fns of: stationes, routes, real-time estiamtes
4. Pick a UI framework that lets us ship a UI to several targets. It may be that one framework doesn't support both and they'll need their own display drivers. If so, make sure the state of the app is decoupled from the display driver. We can then bundle the app for the different targets with their own display wrappers.
  1. initial: web, ideally a small static site we can serve from nginix, this would run in the users browser, ideally all rust, wasm would be good.
  2. eventual: embedded LCD/LED display powered by a pi or ESP32

## BART Developers

https://www.bart.gov/about/developers

* https://www.bart.gov/schedules/developers/gtfs
* https://www.bart.gov/schedules/developers/geo
* https://www.bart.gov/schedules/developers/maps
* https://api.bart.gov/docs/overview/index.aspx
* https://api.bart.gov/docs/overview/examples.aspx

### Legacy API

* [Stations](https://api.bart.gov/api/stn.aspx?cmd=stns&key=MW9S-E7SL-26DU-VV8V&json=y)
* [Routes](https://api.bart.gov/api/route.aspx?cmd=routes&key=MW9S-E7SL-26DU-VV8V&json=y)
* [Real-Time Estimates](https://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&key=MW9S-E7SL-26DU-VV8V&json=y)
  * [Filtered Real-Time Estimates](https://api.bart.gov/api/etd.aspx?cmd=etd&orig=12th&key=MW9S-E7SL-26DU-VV8V&dir=n&json=y)

Test fixtures of each of these are in `tests/fixtures`.

### GTFS

I'm not sure what the advantage of this is over the Legacy API. I want real-time updates. It looks like there is a real-time extension to this feed. However, I'm not sure exactly what that does.

### Maps

The open source maps are pretty sweet. I'm able to open up the `.ai` files in inkscape. I can see all the layers. I'd eventually want to have a map view that renders real-time updates over the maps.