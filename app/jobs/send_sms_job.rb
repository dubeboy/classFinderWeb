class SendSmsJob < ApplicationJob
  queue_as :default
  include Messenger


  def perform(number, msg)
      send_sms(number, msg)
  end
end
