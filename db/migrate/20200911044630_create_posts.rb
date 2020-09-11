class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :title
      t.string :url
      t.text :selftext
      t.integer :score, index: true
      t.string :author, index: true
      t.string :subreddit, index: true
      t.boolean :locked
      t.boolean :is_self
      t.integer :num_comments
      t.integer :num_crossposts
      t.timestamp :created_utc
      t.integer :edited
      t.integer :hidden
      t.string :removal_reason

      t.timestamps
    end
  end
end
