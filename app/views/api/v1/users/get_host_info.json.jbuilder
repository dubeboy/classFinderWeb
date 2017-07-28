  json.transactions do
    json.array! @t do |t|
      a = get_accom(t) #accommodation!
      u = get_user(t) # the student!
      json.email u.email
      json.price a.price
      json.host_id a.user_id
      json.student_id u.id
      json.room_address a.house.address
      json.contact u.contacts
      json.location a.house.location
      json.room_type a.room_type
      json.accom_views a.views
      json.host_name a.user.name
      json.view_date t.month
      json.view_time t.time
    end
  end
