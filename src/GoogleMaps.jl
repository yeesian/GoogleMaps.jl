module GoogleMaps

    import JSON, Requests, ImageMagick

    include("utils.jl")
    include("directions.jl")
    include("geocode.jl")
    include("nearby.jl")
    include("search.jl")
    include("details.jl")
    include("photos.jl")

end
