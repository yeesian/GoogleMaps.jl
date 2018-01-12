# https://developers.google.com/places/web-service/photos
photo(; kwargs...) = requestimage("place/photo"; kwargs...)

"""
Returns a photo corresponding to `photoref`, with specified `maxwidth`.

When you get place information using a Place Details request, photo references
will be returned for relevant photographic content. The Nearby Search and Text
Search requests also return a single photo reference per place, when relevant.
Using the Photo service you can then access the referenced photos and resize the
image to the optimal size for your application.

https://developers.google.com/places/web-service/photos

## Parameters
* `key`: your google maps API key
* `photoref`: A string identifier that uniquely identifies a photo. Photo
    references are returned from either a Place Search or Place Details request.
* `maxwidth`: Specifies the maximum desired width (between 1 and 1600 pixels) of
    the image. If the image is smaller than `maxwidth`, the original image will
    be returned. If the image is larger, it will be scaled to match, restricted
    to its original aspect ratio.
"""
photo(key::String, photoref::String, maxwidth::Int=400; kwargs...) =
    photo(key=key, photoreference=photoref, maxwidth=maxwidth; kwargs...)

# results5 = GoogleMaps.photo("AIzaSyDuGVOl_C0G8vGT8buABSZcYNl8X7Dhho4", "CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU")
