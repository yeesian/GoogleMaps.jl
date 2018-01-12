using GoogleMaps
using Base.Test

# write your own tests here
@testset "Decode Polyline Algorithm" begin
    lonlats = [(-120.2, 38.5), (-120.95, 40.7), (-126.453, 43.252)]
    for (i,lonlat) in enumerate(GoogleMaps.decodepolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@"))
        @test all(lonlat .≈ lonlats[i])
    end
end

@testset "Geocoding" begin
    result = GoogleMaps.geocode("1600 Amphitheatre Parkway, Mountain View, CA")
    @test !isempty(result)
end

@testset "Routing" begin
    sleep(10)
    result1 = GoogleMaps.transitdirections(
        "MBTA Kendall Square",
        "Logan International Airport"
    )
    sleep(10)
    result2 = GoogleMaps.transitdirections(
        (-71.0862274, 42.3622273), (-71.0095602, 42.3656132)
    )
    @test !isempty(result1)
    @test !isempty(result2)
    @test length(result1) == length(result2)

    routes1 = GoogleMaps.getroutes(result1)
    @test isa(routes1, Vector{GoogleMaps.Route})
    @test length(result1) == length(routes1)

    routes2 = GoogleMaps.getroutes(result2)
    @test isa(routes2, Vector{GoogleMaps.Route})
    @test length(result2) == length(routes2)
end
