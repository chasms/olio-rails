class Addons < ActiveRecord::Migration[5.0]
  def change
  	create_table :addons do |t|
      t.string :url
      t.integer :initial_height
      t.integer :initial_width

      t.timestamps
    end
  end
end
