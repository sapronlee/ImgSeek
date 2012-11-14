class CreateScenics < ActiveRecord::Migration
  def change
    create_table :scenics do |t|
      t.string          :name,            :null => false
      t.integer         :pictures_count,  :default => 0
      t.timestamps
    end
  end
end
