class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name

      t.timestamps
    end
    add_index :shops, :name, unique: true
  end
end
