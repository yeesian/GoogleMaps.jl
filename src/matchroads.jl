mutable struct Points
    lonlats::Vector{Tuple{Float64,Float64}}
    placeids::Vector{String}
    originalindex::Vector{Int}
end

function getpoints(points::Vector, originalindex::Vector{Int})
    for (i,p) in enumerate(points)
        if haskey(p, "originalIndex")
            originalindex[p["originalIndex"]+1] = i
        end
    end
    Points(
        [(l["location"]["longitude"],l["location"]["latitude"]) for l in points],
        [l["placeId"] for l in points],
        originalindex
    )
end

function matchroads(snap::Bool, npoints::Int; kwargs...)
    resultjson = if snap
        requestjson("snapToRoads", "https://roads.googleapis.com/v1/", ""; kwargs...)
    else
        requestjson("nearestRoads", "https://roads.googleapis.com/v1/", ""; kwargs...)
    end
    getpoints(resultjson["snappedPoints"], fill(0, npoints))
end

"""

The Google Maps Roads API takes takes up to 100 independent coordinates, and
returns the closest road segment for each point. The points passed do not need
to be part of a continuous path.

If you are working with sequential GPS points, set `snap=true`.

## Parameters
* `key`: your google maps API key
* `lonlats`: the list of points to match

## Keyword Arguments
* `snap`: if you are working with sequential GPS points
* `interpolate`: (only for `snap=true`) Whether to include all points forming
    the full road geometry. When true, additional interpolated points will also
    be returned, resulting in a path that smoothly follows the geometry of the
    road, even around corners and through tunnels. Interpolated paths will most
    likely contain more points than the original path. Defaults to `false`.

## Remarks
The snapping algorithm works best for points that are not too far apart. If you
observe odd snapping behavior, try creating paths that have points closer
together. To ensure the best snap-to-road quality, you should aim to provide
paths on which consecutive pairs of points are within 300m of each other. This
will also help in handling any isolated, long jumps between consecutive points
caused by GPS signal loss, or noise.
"""
function matchroads(
        key::String,
        lonlats::Vector;
        snap::Bool = false,
        maxcoords::Int = 100,
        kwargs...
    )
    npoints = length(lonlats)
    if npoints > 100
        warn("The API takes up to 100 lon,lats. Ignoring coords 101...$npoints")
        npoints = min(maxcoords, npoints)
    end
    points = join([string(lonlats[i][2], ",", lonlats[i][1]) for i in 1:npoints], "|")
    if snap
        matchroads(snap, npoints, key = key, path = points; kwargs...)
    else
        matchroads(snap, npoints, key = key, points = points; kwargs...)
    end
end
