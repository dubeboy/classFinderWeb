json.houses do
  json.array! @houses do |h|
  	json.id h.id
  	json.address h.address
  	json.wifi h.wifi
  	json.user_id h.user_id
  	json.nsfas h.nsfas
  	json.common h.common
  	json.prepaid_elec h.prepaid_elec
  	json.location h.location
  	json.city h.city
  	json.country h.country
  	json.pictures h.pictures do |p|
         json.image_id p.id
         json.image_name p.image_file_name
         json.image_size p.image_file_size
         json.image_url p.image.url(:thumb)
     end
  end 
end