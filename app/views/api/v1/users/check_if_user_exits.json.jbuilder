json.exits @exits
if @exits
	json.results do 
		json.id @u.id
		json.runner @u.runner
	end
end
