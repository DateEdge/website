class CreateRedFlags < ActiveRecord::Migration
  def change
    create_table :red_flags do |t|
      t.integer :user_id
      t.integer :reporter_id

      t.timestamps
    end
  end
end
