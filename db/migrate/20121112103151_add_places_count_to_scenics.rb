class AddPlacesCountToScenics < ActiveRecord::Migration
  def change
    add_column :scenics, :places_count, :integer, :default => 0
  end
end
