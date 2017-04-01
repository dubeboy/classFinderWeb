json.network_posts do 
	json.array! @network_posts do |n|
	json.id n.id
	json.poster_name n.user.name
	json.description n.description
	json.time time_ago_in_words(n.created_at)
	json.likes n.likes
	json.comments do
    json.array! n.comments do |comment|
      json.comment = comment.com
      json.user_name = comment.user.name
    end
  end
	json.poster_img_url n.user.profile_img.url(:thumb)
	json.post_img_url n.pictures[0].nil? ? "" : n.pictures[0].image.url(:thumb)
	end
end 
