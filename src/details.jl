# https://developers.google.com/places/web-service/details
function details(; kwargs...)
    resultjson = requestjson("place/details"; kwargs...)
    if resultjson["status"] == "OK"
        return resultjson["result"]
    else
        return []
    end
end

details(key::String, placeid::String; kwargs...) =
    details(key=key, placeid=placeid; kwargs...)

# results3 = GoogleMaps.details("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "ChIJN1t_tDeuEmsRUsoyG83frY4")
