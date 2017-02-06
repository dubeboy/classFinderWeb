json.status @status
if @status 
  json.results do 
	json.id @u.id
	json.email @u.email
	json.runner @u.runner
  end
end
