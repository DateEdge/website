class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :conversation_id, :sender_id, :recipient_id
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
