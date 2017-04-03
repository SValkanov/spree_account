class AddUsernameToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :username, :string
  end
end
