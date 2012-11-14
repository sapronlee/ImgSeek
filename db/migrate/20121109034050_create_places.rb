class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.references      :scenic
      t.string          :name,            :null => false
      t.string          :description
      t.string          :audio
      t.string          :audio_type
      t.integer         :audio_size,      :default => 0
      t.string          :cover
      t.string          :cover_type
      t.integer         :cover_size,      :default => 0
      t.integer         :pictures_count,  :default => 0
      t.timestamps
    end
  end
end
