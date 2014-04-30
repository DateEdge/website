class CreateRedFlags < ActiveRecord::Migration
  def change
    create_table :red_flags do |t|
      t.integer :flaggable_id
      t.string  :flaggable_type
      t.integer :reporter_id

      t.timestamps
    end
  end
end
