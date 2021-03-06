class SendSmsJob < ApplicationJob
  queue_as :default
  # i//nclude Tasks::Messenger


  def perform(number, msg)
    send_sms(number, msg)
  end


  private
  def send_sms(number, msg)


    num = clean_number(number)
    puts '----------------number'
    puts num
    puts '----------------numberENd'
    acc_sid = 'ACe7a0b94d75993001ab22ee5fe9549f5b'
    auth_token = 'ef7b665c8699cb9b293b79ea1f60451d'
    @client = Twilio::REST::Client.new(acc_sid, auth_token)
    message = @client.account.messages.create(
        from: '+12025172570',
        to: num,
        body: msg)
  end

  def clean_number(n)
    number = n.scan(/\d+/).join
    number[0] == '0' ? number = '+27' + number[1..10] : number
    number
  end
end
