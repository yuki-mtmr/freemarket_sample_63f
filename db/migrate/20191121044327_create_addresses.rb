class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string      :first_name
      t.string      :last_name
      t.string      :first_name_kana
      t.string      :last_name_kana
      t.integer     :postal_code
      t.string      :region
      t.string      :city
      t.string      :street
      t.string      :building
      t.references  :user_id, foreign_key: true
      t.integer     :phone_number
      t.timestamps
    end
  end
end
