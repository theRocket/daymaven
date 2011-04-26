class AddAverageRatingToDays < ActiveRecord::Migration
  def self.up
	add_column :days, :average_rating, :decimal, :precision=> '2', :default => '3'
  end

  def self.down
    remove_column :day, :average_rating
  end
end
