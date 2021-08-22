class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name, index: true, unique: true
      t.string :address
      t.timestamps
    end
  end
end
