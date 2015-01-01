class NotificationJob
  @queue = :notification

  def self.perform(notification_type, *args)
    Notification.send(notification_type, *args).deliver
  end

end
