status = false
json.results do    
    if @user
         json.id @user.id
         json.email @user.email
         json.passord "private stuff"
         status = true
    else
        json.email  "nothing"
        json.password "nothing"
    end
end
json.status status
message = ""
status ? message = "You have succesfully logged in dankie boss" : message =  "Not signed in man sorry, please try again"
json.message message