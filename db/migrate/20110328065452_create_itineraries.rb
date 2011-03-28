class CreateItineraries < ActiveRecord::Migration
  def self.up
    create_table :itineraries do |t|
      t.string :day_of_week
      t.date :date
      t.time :time_start
      t.time :time_end
      t.integer :sequence
      t.references :day
      t.references :activity

      t.timestamps
    end
  end

  def self.down
    drop_table :itineraries
  end
end
