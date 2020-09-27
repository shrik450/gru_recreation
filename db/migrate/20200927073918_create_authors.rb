class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors, id: false do |t|
      t.string :name, null: false, primary_key: true
      t.integer :last_post_n
      t.integer :last_comment_n

      t.timestamps
    end
  end
end
