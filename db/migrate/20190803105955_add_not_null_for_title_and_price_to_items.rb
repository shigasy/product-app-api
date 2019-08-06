class AddNotNullForTitleAndPriceToItems < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :title, :string, null: false
    change_column :items, :price, :integer, null: false
  end

  def down
    change_column :items, :title, :string, null: true
    change_column :items, :price, :integer, null: true
  end
end
