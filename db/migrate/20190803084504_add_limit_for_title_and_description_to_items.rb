class AddLimitForTitleAndDescriptionToItems < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :title, :string, limit: 100
    change_column :items, :description, :string, limit: 500
  end

  def down
    change_column :items, :description, :string
    change_column :items, :title, :string
  end
end
