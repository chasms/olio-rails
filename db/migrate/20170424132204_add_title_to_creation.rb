class AddTitleToCreation < ActiveRecord::Migration[5.0]
  def change
    add_column :creations, :title, :string
  end
end
