class EditDescriptionToPlaces < ActiveRecord::Migration
  def up
    change_column :places, :description, :text
  end

  def down
    change_column :places, :description, :string
  end
end
