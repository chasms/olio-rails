class AddCategoriesToAddons < ActiveRecord::Migration[5.0]
  def change
    add_reference :addons, :category, foreign_key: true
  end
end
