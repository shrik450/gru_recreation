# typed: true

class AddUserPostingStats < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :author_n, :integer
    add_column :comments, :author_n, :integer
  end
end
