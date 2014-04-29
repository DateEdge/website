class RedFlag < ActiveRecord::Base
  belongs_to :user
  belongs_to :reporter, class_name: "User"
end
