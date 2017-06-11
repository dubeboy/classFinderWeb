json.networks do
     json.array! @networks do |n|
       json.id n.id
       json.name n.name
       json.desc n.desc
       json.subscribed n.subscriptions.where("user_id = ?", @current_user.id).first.nil? ? false : true
       json.network_category_id n.network_category_id
       json.creator_id n.user.id
    end
end
