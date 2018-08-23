class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.string :title
      t.string :author
      t.decimal :price
      t.integer :user_id
    end
  end
end
