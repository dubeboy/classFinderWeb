module Messenger
	def send_sms(number, msg)
		num = clean_number(number)
		puts '----------------number'
		puts num
		puts '----------------numberENd'
		acc_sid = 'AC52d32eedceed3f60e1c5eb305fdab7c0'
		auth_token = 'bb6464dd0d9809d514c44ff490d8d4c6'
		@client = Twilio::REST::Client.new(acc_sid, auth_token)
		message = @client.account.messages.create(
			from: '+12025172570', to: num, body: msg)
	end	

	private
	def clean_number(n)
      number = n.scan(/\d+/).join
      number[0] == '0' ? number = '+27' + number[1..10] : number
      return number
  end
end