json.transactions do
    json.array! @trans_by_this_user do |t|
      a = get_accom(t) #accommodation!
      u = get_user(t)
      json.email a.user.email
      json.price a.price
      json.host_id a.user_id
      json.student_id u.id
      json.room_address a.house.address
      json.student_contact a.user.contacts
      json.location a.house.location
      json.room_type a.room_type
      json.accom_views a.views
      json.host_name a.user.name
      json.view_date t.month
      json.view_time t.time
    end
end