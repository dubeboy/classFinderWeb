
json.array! @acs do |i|
     json.id = i.id
     json.city i.city
     json.names i.name
     json.institution i.institution
     json.price i.price
     json.pictures i.pictures do |p|
        json.image_id p.id
        json.image_name p.image_file_name
        json.image_size p.image_file_size
        json.image_url = p.image.url
     end
end



