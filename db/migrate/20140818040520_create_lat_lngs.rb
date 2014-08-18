class CreateLatLngs < ActiveRecord::Migration
  def change
    create_table :lat_lngs do |t|
      t.decimal :lat, precision: 6, scale: 3
      t.decimal :lng, precision: 6, scale: 3
      t.string :username, :location
      t.text :avatar
      t.belongs_to :user

      t.timestamps
    end
  end
end
