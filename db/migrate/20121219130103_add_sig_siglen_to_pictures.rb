class AddSigSiglenToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :sig, :binary, :limit => 10.megabyte
    add_column :pictures, :siglen, :integer
  end
end
