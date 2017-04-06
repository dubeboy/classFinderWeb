json.comments do
	json.array! @comments do |com|
		json.comment com.com
		json.user_name com.user.name
	end 
end 
