  i = @ac   
     json.id i.id
     json.host_id i.user.id
     json.room_type i.room_type
     json.price i.price
     json.description i.description
     json.deposit i.deposit
     json.pictures i.pictures do |p|
        json.image_id p.id
        json.image_name p.image_file_name
        json.image_size p.image_file_size
        json.image_url p.image.url(:thumb)
     end
     house = i.house
     json.house do
       json.city house.city
       json.common house.common
       json.country house.country
       json.location house.location
       json.near_tos house.near_tos.map {|n| n.location}
       json.prepaid_elec house.prepaid_elec
       json.wifi house.wifi
       json.nsfas house.nsfas
       json.address house.address
       json.pictures house.pictures do |p|
         json.image_id p.id
         json.image_name p.image_file_name
         json.image_size p.image_file_size
         json.image_url p.image.url(:thumb)
       end
  end