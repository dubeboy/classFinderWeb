class NotifyWorker
  include Sidekiq::Worker

  def perform(token, body, title)
    fcm = FCM.new("AAAA1bX_T6E:APA91bF44bl-SvZnjFLZbS1UblrWlx6jhTuMkgEcu_pb4XAdOuSj6IhacVCmEWtlrHcaA2DR4E2FUMXXlY-TrAuoJj9lDt8AXpoelniCxlsh7ii8xulNMMrW47n4upp4UVMk5lTmjtQ1")
     # an array of one or more client registration tokens
    # options = {data: {score: "123"}, collapse_key: "updated_score"}
    puts '------------shsbs'
    puts token

    puts '--------'
    options = {notification: {body: body, title: title}}
    # options = { to: #{u.fcm_token}, notification: {body: body, title: title}
    response = fcm.send(registration_ids= [token], options)
    puts response
  end
end
