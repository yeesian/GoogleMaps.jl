mutable struct Location
    lonlat::Tuple{Float64,Float64}
    placeid::String
    address::String
    locationtype::String
    tags::Vector{String}
end

function Base.show(io::IO, loc::Location)
    pprint(s::String, width::Int=50) =
        length(s) > width ? string(s[1:(width-3)], "...") : s
    println(io, "Location")
    println(io, "========")
    println(io, " *    type: ", pprint(loc.locationtype))
    println(io, " * address: ", pprint(loc.address))
    println(io, " *    tags: (",length(loc.tags),") ", pprint(join(loc.tags," | ")))
end

function getlocation(loc::Dict)
    geom = loc["geometry"]
    Location(
        (geom["location"]["lng"], geom["location"]["lat"]), loc["place_id"],
        loc["formatted_address"], geom["location_type"], loc["types"]
    )
end

function geocode(;kwargs...)
    resultjson = requestjson("geocode"; kwargs...)
    if resultjson["status"] == "OK"
        return resultjson["results"]
    else
        return []
    end
end

"""

Geocoding is the process of converting addresses (like "1600 Amphitheatre
Parkway, Mountain View, CA") into geographic coordinates (like latitude
37.423021 and longitude -122.083739).

https://developers.google.com/maps/documentation/geocoding/intro

## Parameters
* `key`: your google maps API key
* `address`: The street address that you want to geocode, in the format used by
    the national postal service of the country concerned. Additional address
    elements such as business names and unit, suite or floor numbers should be
    avoided. Please refer to the FAQ for additional guidance.
    https://developers.google.com/maps/faq#geocoder_queryformat

## Remarks
The geocoder is designed to map street addresses to geographical coordinates.
We therefore recommend that you format geocoder requests in accordance with the
following guidelines to maximize the likelihood of a successful query:

* Specify addresses in accordance with the format used by the national postal
    service of the country concerned.
* Do not specify additional address elements such as business names, unit
    numbers, floor numbers, or suite numbers that are not included in the
    address as defined by the postal service of the country concerned. Doing so
    may result in responses with ZERO_RESULTS.
* Use the street number of a premise over the building name where possible.
* Use street number addressing over specifying cross streets where possible.
* Do not provide 'hints' such as nearby landmarks.

https://developers.google.com/maps/faq#geocoder_queryformat

"""
geocode(address::String; kwargs...) = geocode(address=address; kwargs...)

"""

The term geocoding generally refers to translating a human-readable address into
a location on a map. The process of doing the opposite, translating a location
on the map into a human-readable address, is known as reverse geocoding.

## Parameters
* `lonlat`: the longitude and latitude values specifying the location for which
    you wish to obtain the closest, human-readable address.

## Keyword Arguments
* (optional but recommended) `key`: your google maps API key

"""
geocode(lon::Float64, lat::Float64; kwargs...) =
    geocode(latlng = string(lat,",",lon); kwargs...)

geocode(lonlat::Tuple{Float64,Float64}; kwargs...) =
    geocode(lonlat...; kwargs...)
