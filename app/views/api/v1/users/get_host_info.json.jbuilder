  json.transactions do
    json.array! @t do |t|
      a = get_accom(t) #accommodation!
      u = get_user(t) # the student!
      json.student_email u.email
      json.student_contact u.contacts
      json.location a.house.location
      json.room_type a.room_type
      json.accom_views a.views
      json.host_name a.user.name
      json.view_date t.month
      json.view_time t.time
    end
  end
