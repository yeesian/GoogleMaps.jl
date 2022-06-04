module GoogleMaps
    using Dates
    import JSON, HTTP, ImageMagick

    include("utils.jl")
    include("directions.jl")
    include("geocode.jl")
    include("nearby.jl")
    include("search.jl")
    include("details.jl")
    include("photos.jl")
    include("matchroads.jl")
    include("distancematrix.jl")
end
