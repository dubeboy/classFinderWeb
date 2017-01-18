json.results do 
    json.runner @user.runner?
    json.time_slots @user.time_slots
    json.trasactions @trans
end