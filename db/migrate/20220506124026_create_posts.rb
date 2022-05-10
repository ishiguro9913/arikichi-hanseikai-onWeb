class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name,                    null: false
      t.text :content,                   null: false
      t.integer :score,                  null: false
      t.text :ablution
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
