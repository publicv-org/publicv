class AddAdminAndOnlineUpdatesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :email_preference_online_updates, :boolean, default: false
  end
end
