json.results do 
  json.array! @acs do |i|
     json.id i.id
     json.host_id i.user.id
     json.location i.location
     json.room_type i.room_type
     json.price i.price
     json.description i.description
     json.pictures i.pictures do |p|
        json.image_id p.id
        json.image_name p.image_file_name
        json.image_size p.image_file_size
        json.image_url p.image.url
     end
   end
end



