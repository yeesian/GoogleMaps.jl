# GoogleMaps

[![Build Status](https://travis-ci.org/yeesian/GoogleMaps.jl.svg?branch=master)](https://travis-ci.org/yeesian/GoogleMaps.jl)
[![Coverage Status](https://coveralls.io/repos/yeesian/GoogleMaps.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/yeesian/GoogleMaps.jl?branch=master)
[![codecov.io](http://codecov.io/github/yeesian/GoogleMaps.jl/coverage.svg?branch=master)](http://codecov.io/github/yeesian/GoogleMaps.jl?branch=master)

## Description
Want to [geocode][Geocoding API] something? Looking for [directions][Directions API]? This library brings the [Google Maps API Web Services] to Julia, and supports the following Google Maps APIs:

- [Directions API]
- [Geocoding API]
- [Places API]
- [Roads API]

Keep in mind that the same [terms and conditions](https://developers.google.com/maps/terms) apply
to usage of the APIs when they're accessed through this library.

## API keys

Each Google Maps Web Service request requires an API key or client ID. API keys
are freely available with a Google Account at https://developers.google.com/console.

To get an API key:

 1. Visit https://developers.google.com/console and log in with a Google Account.
 2. Select one of your existing projects, or create a new project.
 3. Enable the API(s) you want to use. GoogleMaps.jl accesses the following APIs:
    * Directions API
    * Geocoding API
    * Places API
    * Roads API
 4. Create a new **Server key**.
 5. If you'd like to restrict requests to a specific IP address, do so now.

For guided help, follow the instructions for the [Directions API][directions-key].
You only need one API key, but remember to enable all the APIs you need.
For even more information, see the guide to [API keys][apikey].

## Usage Limits
https://developers.google.com/maps/documentation/directions/usage-limits

## Displaying a map
The Google Maps Directions API may only be used in conjunction with displaying
results on a Google map. It is prohibited to use Google Maps Directions API data
without displaying a Google map.

## Attributions for third-party content
If the response from the Google Maps Directions API includes transit details,
your application must display the names and URLs of the transit agencies that
supply the trip results. See the agencies array in the Google Maps Directions
API response for a specification of the relevant fields. We recommend that you
place this information below any Google Maps Directions API data.

## Providing terms of use and privacy policy
If you develop a Google Maps Directions API application, you must make available
a Terms of Use and a Privacy Policy with your application which meets the
guidelines outlined in section 9.3 of the Google Maps APIs Terms of Service:

    * Your Terms of Use and Privacy Policy must be publicly available.
    * You must explicitly state in your application's Terms of Use that by using
        your application, users are bound by Google’s Terms of Service.
    * You must notify users in your Privacy Policy that you are using the Google
        Maps API(s) and incorporate by reference the Google Privacy Policy.

[apikey]: https://developers.google.com/maps/faq#keysystem
[directions-key]: https://developers.google.com/maps/documentation/directions/get-api-key#key
[Google Maps API Web Services]: https://developers.google.com/maps/documentation/webservices/
[Directions API]: https://developers.google.com/maps/documentation/directions
[Geocoding API]: https://developers.google.com/maps/documentation/geocoding
[Places API]: https://developers.google.com/places/web-service/
[Roads API]: https://developers.google.com/maps/documentation/roads
