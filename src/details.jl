# https://developers.google.com/places/web-service/details
function details(; kwargs...)
    resultjson = requestjson("place/details"; kwargs...)
    if resultjson["status"] == "OK"
        return resultjson["result"]
    else
        return []
    end
end

"""
Returns the results of a place details request.

Once you have a place_id or a reference from a Place Search, you can request
more details about a particular establishment or point of interest by initiating
a Place Details request. A Place Details request returns more comprehensive
information about the indicated place such as its complete address, phone
number, user rating and reviews.

https://developers.google.com/places/web-service/details

## Parameters
* `key::String`: Your Google Maps API Key.
* `placeid`: An identifier that uniquely identifies a place, returned from a
    Place Search. For more information about place IDs, see the place ID
    overview https://developers.google.com/places/web-service/place-id.

"""
details(key::String, placeid::String; kwargs...) =
    details(key=key, placeid=placeid; kwargs...)

# results3 = GoogleMaps.details("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "ChIJN1t_tDeuEmsRUsoyG83frY4")
