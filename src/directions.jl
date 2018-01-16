mutable struct Route
    copyrights::String
    startaddress::String
    endaddress::String
    travelmode::Vector{String}
    traveltime::Vector{Int} # seconds
    traveldist::Vector{Int} # kilometers
    lonlat::Vector{Tuple{Float64,Float64}}
    bbox::Tuple{Float64,Float64,Float64,Float64} # minlon,minlat,maxlon,maxlat
    instructions::Vector{String}
    misc::Dict{String,Any}
    polylines::Vector{Vector{Tuple{Float64,Float64}}}

    Route() = new()
end

function directions(;kwargs...)
    resultjson = requestjson("directions"; kwargs...)
    if resultjson["status"] == "OK"
        return getroutes(resultjson["routes"])
    else
        return Route[]
    end
end

"""
Returns a vector of transit routes under the GoogleMaps Directions API.

## Parameters
    
* `origin`: the origin location. 
* `dest`: the destination location. 
* [optional] `datetime`: defaults to the current time

See https://developers.google.com/maps/documentation/directions/intro
for details on the origin and destination specification.

## Keyword Arguments

* `key::String`: Your Google Maps API Key.
* `mode`: includes `driving` (default), `walking`, `bicycling`, `transit`.
* `alternatives::Bool` (default: `true`): specifies whether the Directions
    service may provide more than one route alternative in the response.
"""
function directions(
        origin::String,
        dest::String,
        datetime::DateTime;
        key::String = "",
        mode::String = "transit",
        alternatives::Bool = true,
        kwargs...
    )
    key != "" && push!(kwargs, (:key, key))
    push!(kwargs, (:departure_time, string(round(Int,Dates.datetime2unix(datetime)))))
    push!(kwargs, (:mode, mode))
    push!(kwargs, (:alternatives, string(alternatives)))
    push!(kwargs, (:origin, origin))
    push!(kwargs, (:destination, dest))
    directions(; kwargs...)
end

directions(origin::String, dest::String; kwargs...) =
    directions(origin, dest, now(); kwargs...)

function directions(
        lonlat_origin::Tuple{Float64,Float64},
        lonlat_dest::Tuple{Float64,Float64},
        args...;
        kwargs...
    )
    directions(
        string(lonlat_origin[2], ",", lonlat_origin[1]),
        string(lonlat_dest[2], ",", lonlat_dest[1]),
        args...; kwargs...
    )
end

function Base.show(io::IO, r::Route)
    pprint(s::String, width::Int=50) =
        length(s) > width ? string(s[1:(width-3)], "...") : s
    println(io, "Route (", r.copyrights, ")")
    println(io, "=====")
    println(io, " *         from: ", pprint(r.startaddress))
    println(io, " *           to: ", pprint(r.endaddress))
    println(io, " * instructions: ", isempty(r.instructions) ? "no" : "yes")
    println(io, " *   travelmode: ", r.travelmode)
end

"""
Returns a list of routes for the result from Google Maps Directions API.

## Parameters

* `polyline::Bool` (default: `true`): whether or not to include the polyline
    corresponding to the route
* `instructions` (default: `true`): whether or not to return the
    instructions for the route.

"""
function getroutes(
        routes::Vector;
        instructions::Bool = true,
        stepcallback::Function = (route, s) -> nothing
    )
    result = Route[]
    sizehint!(result, length(routes))
    for r in routes
        route = Route()
        route.copyrights = r["copyrights"]; route.misc = Dict()
        
        minlon = r["bounds"]["southwest"]["lng"]
        minlat = r["bounds"]["southwest"]["lat"]
        maxlon = r["bounds"]["northeast"]["lng"]
        maxlat = r["bounds"]["northeast"]["lat"]
        route.bbox = (minlon,minlat,maxlon,maxlat)

        @assert length(r["legs"]) == 1 # no waypoints
        leg = r["legs"][1]
        
        route.startaddress = leg["start_address"]
        route.endaddress = leg["end_address"]

        steps = leg["steps"]
        @assert length(steps) >= 1
        route.travelmode = [s["travel_mode"] for s in steps]
        route.traveltime = [s["duration"]["value"] for s in steps]
        route.traveldist = [s["distance"]["value"] for s in steps]
        
        route.instructions = instructions ? [s["html_instructions"] for s in steps] : []
        route.polylines = [decodepolyline(s["polyline"]["points"]) for s in steps]
        
        startlon = steps[1]["start_location"]["lng"]
        startlat = steps[1]["start_location"]["lat"]
        route.lonlat = [(startlon,startlat)]
        sizehint!(route.lonlat, length(steps))
        for s in steps
            stepcallback(route, s)
            lonlat = (s["end_location"]["lng"], s["end_location"]["lat"])
            push!(route.lonlat, lonlat)
        end
        push!(result, route)
    end
    result
end
