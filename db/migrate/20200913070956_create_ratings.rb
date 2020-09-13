class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :post_id, null: false, index: true
      t.integer :rating, null: false

      t.timestamps

      t.index %i[user_id post_id], unique: true
    end
  end
end
