class Notification < ActionMailer::Base
  default from: "us@dateedge.com"

  def new_message(message_id)
    @message = Message.find(message_id)
    @recipient = @message.recipient
    @sender    = @message.sender
    mail to: @recipient.email, subject: "You have a new message from #{@sender.username}"
  end

  def new_crush
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
