class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname,         :string
    add_column :users, :first_name,       :string
    add_column :users, :last_name,        :string
    add_column :users, :first_name_kana,  :string
    add_column :users, :last_name_kana,   :string
    add_column :users, :birth_year,       :integer
    add_column :users, :birth_month,      :integer
    add_column :users, :birth_day,        :integer
    add_column :users, :phone_number,     :string, unique: true
    add_column :users, :image,            :string
    add_column :users, :evaluation,       :integer
  end
end
