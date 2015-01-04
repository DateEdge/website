class Notification < ActionMailer::Base
  default from: "us@dateedge.com"

  def new_message(message_id)
    @message   = Message.find(message_id)
    @recipient = @message.recipient
    @sender    = @message.sender
    mail to: @recipient.email, subject: "Date Edge: You have a new message from @#{@sender.username}"
  end

  def new_crush(crush_id)
    @crush     = Crush.find(crush_id)
    @recipient = @crush.crushee
    @sender    = @crush.crusher
    mail to: @recipient.email, subject: "Date Edge: You were crushed on by @#{@sender.username}"
  end
end
