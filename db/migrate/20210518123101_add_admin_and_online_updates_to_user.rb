class AddAdminAndOnlineUpdatesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :email_preference_email_preference_online_updates, :boolean
  end
end
