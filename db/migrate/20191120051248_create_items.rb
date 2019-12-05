class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer "price", null: false
      t.integer "status",   default: "0", null: false
      t.string "name", default: "", null: false
      t.string "condition", default: "", null: false
      t.text "description", null: false
      t.string "item_size", default: ""
      t.string "region", default: "", null: false
      t.string "postage", default: "", null: false
      t.string "shipping_date", default: "", null: false 
      t.string  :user_id, foreign_key: true
      t.timestamps
    end
  end
end
