class AddTwitterUserNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_user_name, :string
  end
end
