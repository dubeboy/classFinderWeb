json.venues do 
	json.array! @open_venues do |v|
		json.name v
	end
end 
