# https://developers.google.com/places/web-service/search
function searchfor(; kwargs...)
    resultjson = requestjson("place/textsearch"; kwargs...)
    if resultjson["status"] == "OK"
        return resultjson["results"]
    else
        return []
    end
end

searchfor(key::String, query::String; kwargs...) =
    searchfor(key=key, query=query; kwargs...)

# results4 = GoogleMaps.searchfor("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "restaurants in Sydney")
