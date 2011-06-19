class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :username
      t.string :email
      t.date   :birthday
      t.string :city
      t.string :state
      t.string :zip
      t.text   :bio
      t.string :me_gender
      t.string :me_gender_map
      t.string :you_gender
      t.string :you_gender_map
      t.belongs_to :country
      t.belongs_to :diet
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
