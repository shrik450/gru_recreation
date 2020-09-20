class AddImageNotPresentToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :image_not_present, :boolean, default: false
  end
end
