class SorceryCore < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :twitter_id,            null: false, index: { unique: true }
      t.string :name,                    null: false, default: "匿名様"

      t.timestamps                null: false
    end
  end
end
