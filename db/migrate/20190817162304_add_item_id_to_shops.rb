class AddItemIdToShops < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :shop, index: true, foreign_key: true
  end
end
