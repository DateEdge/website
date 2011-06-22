class Label < ActiveRecord::Base
  validates :name, :presence => true
  
  class << self
    def options_for_select
      Label.all.map{ |d| [d.name, d.id] }
    end
  end
end
