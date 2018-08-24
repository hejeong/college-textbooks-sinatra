class AddOwnerColumnToTextbooks < ActiveRecord::Migration
  def change
    add_column :textbooks, :owner_id, :integer
  end
end
