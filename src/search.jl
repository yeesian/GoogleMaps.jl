# https://developers.google.com/places/web-service/search
function searchfor(; kwargs...)
    resultjson = requestjson("place/textsearch"; kwargs...)
    if resultjson["status"] == "OK"
        return resultjson["results"]
    else
        return []
    end
end

"""
Returns information about a set of places based on a string — for example
"pizza in New York" or "shoe stores near Ottawa" or "123 Main Street".

https://developers.google.com/places/web-service/search#TextSearchRequests

## Parameters
* `key`: your google maps API key
* `query`: The text string on which to search, for example: "restaurant" or
    "123 Main Street". The Google Places service will return candidate matches
    based on this string and order the results based on their perceived
    relevance. This parameter becomes optional if the type parameter is also
    used in the search request.

## Keyword Arguments
* `location::String`: The latitude/longitude around which to retrieve place
    information. This must be specified as latitude,longitude. If you specify a
    location parameter, you must also specify a `radius` parameter.
* `radius`: The distance (meters) within which to bias place results. The
    maximum allowed radius is 50,000 meters. Results inside of this region will
    be ranked higher than results outside of the search circle; however,
    prominent results from outside of the search radius may be included.
* `opennow`: Returns only those places that are open for business at the time
    the query is sent. Places that do not specify opening hours in the Google
    Places database will not be returned if you include this parameter.
* `pagetoken`: Returns the next 20 results from a previously run search. Setting
    a pagetoken parameter will execute a search with the same parameters used
    previously — all parameters other than pagetoken will be ignored.
* `type`: Restricts the results to places matching the specified type. Only one
    type may be specified (if more than one type is provided, all types
    following the first entry are ignored).

## Remark
The Google Places search services share the same usage limits. However, the Text
Search service is subject to a 10-times multiplier. That is, each Text Search
request that you make will count as 10 requests against your quota.

So you should consider using the `details()` method (where possible) instead.
"""
searchfor(key::String, query::String; kwargs...) =
    searchfor(key=key, query=query; kwargs...)

# results4 = GoogleMaps.searchfor("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "restaurants in Sydney")
