class SmsWorker
  include Sidekiq::Worker

  def perform(number, msg)

    number = number.scan(/\d+/).join
    number[0] == '0' ? number = '+27' + number[1..10] : number
    puts '----------------number'
    puts number
    puts '----------------numberENd'
    acc_sid = 'ACe7a0b94d75993001ab22ee5fe9549f5b'
    auth_token = 'ef7b665c8699cb9b293b79ea1f60451d'
    @client = Twilio::REST::Client.new(acc_sid, auth_token)
    message = @client.account.messages.create(
        from: '+12025172570',
        to: number,
        body: msg)
  end
end
