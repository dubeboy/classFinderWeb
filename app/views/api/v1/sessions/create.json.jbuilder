status = false
json.results do    
    if @user
         json.id @user.id
         json.runner @user.runner?
         json.email @user.email
         json.passord "private stuff"
         json.token @user.token
         status = true
    else
        json.email  "nothing"
        json.password "nothing"
    end
end
json.status status
status ? message = 'You have successfully logged in dankie boss' : message = 'Not signed in sorry, please try again'
json.message message