class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.references :menu, index: true
      t.boolean :may_retry, default: false
      t.text :context
      t.timestamps
    end
  end
end
