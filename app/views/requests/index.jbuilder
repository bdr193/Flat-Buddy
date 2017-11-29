

# json.array!(@requests) do |request|

#   if request.status == "accepted"
#     request[:title] = request.viewing.room.flat.title
#     request.address = request.viewing.room.flat.address
#     request.start_time = Date.parse("#{request.slot}")
#     json.extract! request, :id, :title, :address, :start_time
#     json.start request.start_time
#     json.end request.start_time
#     json.url request_url(request, format: :json)
#   end
# end

json.array!(@requests) do |request|

    json.extract! request, :id, :slot
    json.url request_url(request, format: :json)

end

