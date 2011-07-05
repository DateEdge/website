class Conversation < ActiveRecord::Base
  
  default_scope joins(:messages).order('messages.updated_at desc')
  has_many :messages
  
end
