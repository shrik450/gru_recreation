class AddSubredditHistoryToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :subreddit_history, :string, array: true
  end
end
