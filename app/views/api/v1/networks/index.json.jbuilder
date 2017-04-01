json.networks do
     json.array! @networks do |n|
       json.id n.id
     json.name n.name
     json.desc n.desc
     json.network_category_id n.network_category_id
    end
end
