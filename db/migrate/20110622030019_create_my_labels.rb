class CreateMyLabels < ActiveRecord::Migration
  def self.up
    create_table :my_labels do |t|
      t.belongs_to :user
      t.belongs_to :label

      t.timestamps
    end
  end

  def self.down
    drop_table :my_labels
  end
end
