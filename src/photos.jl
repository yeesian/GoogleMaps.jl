# https://developers.google.com/places/web-service/photos
photo(; kwargs...) = requestimage("place/photo"; kwargs...)

photo(key::String, photoref::String, maxwidth::Int=400; kwargs...) =
    photo(key=key, photoreference=photoref, maxwidth=maxwidth; kwargs...)

# results5 = GoogleMaps.photo("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU")
