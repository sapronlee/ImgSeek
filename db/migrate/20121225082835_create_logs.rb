class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :ip
      t.datetime :time
      t.text :msg

      t.timestamps
    end
  end
end
