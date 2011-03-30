class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.text :description
      t.string :day_of_week
      t.date :date
      t.time :time_start
      t.time :time_end
      t.integer :sequence
      t.references :day
      t.references :place

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
