class CreateSalers < ActiveRecord::Migration[5.2]
  def change
    create_table :salers do |t|
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
