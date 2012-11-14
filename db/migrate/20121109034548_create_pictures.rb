class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references  :place
      t.references  :scenic
      t.string      :image
      t.string      :image_type
      t.integer     :image_size
      t.timestamps
    end
  end
end
