function nearby(; kwargs...)
    resultjson = requestjson("place/nearbysearch"; kwargs...)
    if resultjson["status"] == "OK"
        return resultjson["results"]
    else
        return []
    end
end

"""
Returns a list of places around a location within the given radius.

## Description

A Nearby Search lets you search for places within a specified area. You can
refine your search request by supplying keywords or specifying the type of
place you are searching for.

https://developers.google.com/places/web-service/search#PlaceSearchRequests

## Parameters

* `key`: your google maps API key
* `lon`: the longitude of the location
* `lat`: the latitude of the location
* `radius`: the distance (in meters) within which to return place results.

## Keyword arguments

* `keyword`: A term to be matched against all content that Google has indexed
    for this place, including but not limited to name, type, and address, as
    well as customer reviews and other third-party content.
* `opennow`: return only places that are open for business at the time the
    query is sent. Places that do not specify opening hours in the Google Places
    database will not be returned if you include this parameter in your query.
* `rankby`: Specifies the order in which results are listed. Note that rankby
    must not be included if radius (described under Required parameters above)
    is specified. Possible values are:
    
    * `prominence` (default). This option sorts results based on their
        importance. Ranking will favor prominent places within the specified
        area. Prominence can be affected by a place's ranking in Google's index,
        global popularity, and other factors.
    * `distance`. This option biases search results in ascending order by their
        distance from the specified location. When distance is specified, one or
        more of keyword, name, or type is required.
* `type`: Restricts the results to places matching the specified type.

"""
function nearby(key::String, lon::Real, lat::Real, radius::Real; kwargs...)
    radius > 50_000 && error("The maximum allowed radius is 50,000 meters.")
    nearby(key = key, location = string(lat,",",lon), radius=radius; kwargs...)
end

nearby(key::String, lonlat::Tuple{Float64,Float64}, radius::Real; kwargs...) =
    nearby(key, lonlat[1], lonlat[2], radius; kwargs...)
