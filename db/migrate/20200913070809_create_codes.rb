class CreateCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :codes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reference_id, null: false, index: true
      t.string :reference_type, null: false, index: true
      t.text :body

      t.timestamps
    end
  end
end
