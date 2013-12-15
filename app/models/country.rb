class Country < ActiveRecord::Base
  has_many :users

  class << self
    def options_for_select
      countries = [
        Country.where(name: "United States").first,
        Country.where(name: "Canada").first
      ]
      countries << Country.order(:name).all

      countries.flatten.map{ |c| [c.name.capitalize, c.id] }
    end
  end

  def to_s
    name.capitalize
  end
end
