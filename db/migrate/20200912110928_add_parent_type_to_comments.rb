# typed: ignore
class AddParentTypeToComments < ActiveRecord::Migration[6.0]
  def up
    add_column :comments, :parent_type, :string
    Rake::Task["data:backfill_parent_type_to_comments"].invoke
    change_column_null :comments, :parent_type, false
  end

  def down
    remove_column :comments, :parent_type
  end
end
