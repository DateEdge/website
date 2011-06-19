class Diet < ActiveRecord::Base
  has_many :users

  class << self
    def options_for_select
      Diet.all.map{ |d| [d.name.capitalize, d.id] }
    end
  end

  def to_s
    name.capitalize
  end
end
