class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string   :image_content_type
      t.string   :image_file_name
      t.datetime :image_updated_at
      t.integer  :image_file_size
      t.text :caption
      t.belongs_to :user

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
