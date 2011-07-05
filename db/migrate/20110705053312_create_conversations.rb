class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.belongs_to :user
      t.integer    :receipient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :conversations
  end
end
