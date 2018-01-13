"""
Returns a Dict corresponding to the results of querying `service`, where

## Parameters
* `service`: one of the Google Maps API (e.g. `geocode` or `directions`)

## Keyword Arguments
Often corresponds to parameters that are passed to the REST-ful API.
"""
function requestjson(
        service::String,
        api::String = "https://maps.googleapis.com/maps/api/",
        ext::String = "/json";
        kwargs...
    )
    result = Requests.get(string(api,service,ext); query = Dict(kwargs))
    resultjson = JSON.parse(Requests.readstring(result))
    info("REQUEST:{\"uri\":\"", result.request.value.uri, "\", ",
                  "\"status\": \"", Requests.statuscode(result), "\"}")
    Requests.statuscode(result) == 400 && warn("ERROR:",resultjson["error"])
    resultjson
end

function requestimage(service::String; kwargs...)
    result = Requests.get(
        "https://maps.googleapis.com/maps/api/$service"; query = Dict(kwargs)
    )
    info("REQUEST:{\"uri\":\"", result.request.value.uri, "\", ",
                  "\"status\": \"", Requests.statuscode(result), "\"}")
    ImageMagick.readblob(result.data)
end

"""
Decodes a sequence of `lonlats` encoded in the polyline algorithm format.

See https://developers.google.com/maps/documentation/utilities/polylinealgorithm
for details.
"""
function decodepolyline(polyline::Vector{UInt8})
    function f(polyline, index)
        x = shift = 0
        while true
            @inbounds block = polyline[index] - 63 # 63 == Int('?')
            x |= (block & 0x1f) << shift
            index += 1; shift += 5
            block >= 0x20 || break
        end
        index, (x & 1) == 1 ? ~(x >> 1) : (x >> 1)
    end

    index = 1; currlat = currlon = 0
    lonlat = Tuple{Float64,Float64}[]
    polylength = length(polyline)
    while index < polylength
        index, dlat = f(polyline, index)
        index, dlon = f(polyline, index)
        currlat += dlat; currlon += dlon
        push!(lonlat, (currlon / 1e5, currlat / 1e5))
    end
    lonlat
end

decodepolyline(s::String) = decodepolyline(Vector{UInt8}(s))
