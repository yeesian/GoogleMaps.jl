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
