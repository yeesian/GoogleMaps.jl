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
    result1 = GoogleMaps.directions(
        "MBTA Kendall Square",
        "Logan International Airport"
    )
    sleep(10)
    result2 = GoogleMaps.directions(
        (-71.0862274, 42.3622273), # Kendall Square
        (-71.0095602, 42.3656132) # Logan Airport
    )
    @test !isempty(result1)
    @test !isempty(result2)
    @test length(result1) == length(result2)
end

# results3 = GoogleMaps.details("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "ChIJN1t_tDeuEmsRUsoyG83frY4")

# result = GoogleMaps.matchroads("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", [(149.12958,-35.27801), (149.12907,-35.28032), (149.12929,-35.28099), (149.12984,-35.28144), (149.13003,-35.28194), (149.12956,-35.28282), (149.12881,-35.28302), (149.12836,-35.28473)], interpolate=true, snap=true)
# result1 = GoogleMaps.matchroads("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", [(24.942795,60.170880), (24.942796,60.170879), (24.942796, 60.170877)])

# results2 = GoogleMaps.nearby("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", (151.1957362,-33.8670522),500, keyword="cruise")


# results4 = GoogleMaps.searchfor("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "restaurants in Sydney")

# results5 = GoogleMaps.photo("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU")
