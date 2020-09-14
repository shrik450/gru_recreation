# typed: ignore
class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.text :body
      t.integer :score, index: true
      t.string :author, index: true
      t.string :subreddit, index: true
      t.string :parent_id, index: true, null: false
      t.boolean :edited
      t.string :removal_reason
      t.boolean :can_gild
      t.boolean :can_mod_post
      t.boolean :collapsed
      t.string :collapsed_reason
      t.integer :controversiality
      t.boolean :distinguished
      t.boolean :is_submitter
      t.boolean :no_follow
      t.boolean :removed
      t.timestamp :created_utc
      t.timestamps
    end
  end
end
