class AddStatusToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :status, :integer, null: false, default: 0
  end
end
