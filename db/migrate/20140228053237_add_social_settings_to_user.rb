class AddSocialSettingsToUser < ActiveRecord::Migration
  # TODO put this into settings

  def up
    add_column :users, :facebook_username,    :string
    add_column :users, :instagram_username,   :string
    add_column :users, :kik_username,         :string
    add_column :users, :lastfm_username,      :string
    add_column :users, :snapchat_username,    :string
    add_column :users, :spotify_username,     :string
    add_column :users, :thisismyjam_username, :string
    add_column :users, :tumblr_username,      :string
    add_column :users, :twitter_username,     :string
    add_column :users, :vine_username,        :string
  end

  def down
    remove_column :users, :facebook_username
    remove_column :users, :instagram_username
    remove_column :users, :kik_username
    remove_column :users, :lastfm_username
    remove_column :users, :snapchat_username
    remove_column :users, :spotify_username
    remove_column :users, :thisismyjam_username
    remove_column :users, :tumblr_username
    remove_column :users, :twitter_username
    remove_column :users, :vine_username
  end
end
