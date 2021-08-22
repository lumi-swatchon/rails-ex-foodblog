class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.references :store, index: true
      t.string :name
      t.integer :price
      t.timestamps
    end
  end
end
