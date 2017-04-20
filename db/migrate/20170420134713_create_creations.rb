class CreateCreations < ActiveRecord::Migration[5.0]
  def change
    create_table :creations do |t|
      t.references :account
      t.json :composition
    end
  end
end
