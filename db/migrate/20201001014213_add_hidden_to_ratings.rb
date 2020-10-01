class AddHiddenToRatings < ActiveRecord::Migration[6.0]
  def change
    add_column :ratings, :hidden, :boolean, default: false
  end
end
