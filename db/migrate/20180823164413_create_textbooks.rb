class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.string :title
      t.string :author
      t.decimal :price
      t.string :image_url
      t.integer :user_id
    end
  end
end
