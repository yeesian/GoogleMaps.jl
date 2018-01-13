
function matchroads(snap::Bool; kwargs...)
    resultjson = if snap
        requestjson("snapToRoads", "https://roads.googleapis.com/v1/", ""; kwargs...)
    else
        requestjson("nearestRoads", "https://roads.googleapis.com/v1/", ""; kwargs...)
    end
    resultjson["snappedPoints"]
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
        warn("The API takes up to 100 lon,lats. Ignoring the rest of $npoints")
        npoints = min(maxcoords, npoints)
    end
    points = join([string(lonlat[i][2],",",lonlat[i][1]) for i in 1:npoints], "|")
    if snap
        matchroads(snap, key = key, path = points; kwargs...)
    else
        matchroads(snap, key = key, points = points; kwargs...)
    end
end
