class AddBuyerColumnToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :buyer_id, :integer
  end
end
