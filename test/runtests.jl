using Revise, GoogleMaps, Test

# write your own tests here
@testset "Decode Polyline Algorithm" begin
    lonlats = [(-120.2, 38.5), (-120.95, 40.7), (-126.453, 43.252)]
    for (exact,decoded) in zip(lonlats,GoogleMaps.decodepolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@"))
        @test all(exact .≈ decoded)
    end
end

sleep(10);

@testset "Geocoding" begin
    result = GoogleMaps.geocode("1600 Amphitheatre Parkway, Mountain View, CA";key)
    @test !isempty(result)
end

sleep(10);

@testset "Routing" begin
    result = GoogleMaps.directions(
        "MBTA Kendall Square",
        "Logan International Airport"; key, alternatives=false
    )
    @test !isempty(result)
end

results3 = GoogleMaps.details("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "ChIJN1t_tDeuEmsRUsoyG83frY4";key)

result = GoogleMaps.matchroads("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", [(149.12958,-35.27801), (149.12907,-35.28032), (149.12929,-35.28099), (149.12984,-35.28144), (149.13003,-35.28194), (149.12956,-35.28282), (149.12881,-35.28302), (149.12836,-35.28473)], interpolate=true, snap=true;key)



result1 = GoogleMaps.matchroads("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", [(24.942795,60.170880), (24.942796,60.170879), (24.942796, 60.170877)];key)



results2 = GoogleMaps.nearby("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", (151.1957362,-33.8670522),500, keyword="cruise";key)

results4 = GoogleMaps.searchfor("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "restaurants in Sydney";key)

results5 = GoogleMaps.photo("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU";key)
