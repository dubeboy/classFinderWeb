json.transactions do
    json.array! @trans_by_this_user do |t|
      a = get_accom(t) #accommodation!
      r = get_runner(t)
      json.accom_id = a.id
      json.student_email r.email
      json.student_contact r.contacts
      json.location a.location
      json.room_type a.room_type
      json.view_date t.month
      json.view_time t.time
    end
end