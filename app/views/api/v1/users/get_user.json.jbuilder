@status = @user.nil? ? false : true 
if @user 
  json.results do
    json.id @user.id
    json.email @user.email
    json.runner @user.runner
    json.token @user.token
    json.fcm_token @user.fcm_token
  end
end
