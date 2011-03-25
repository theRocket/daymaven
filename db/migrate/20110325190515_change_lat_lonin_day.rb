class ChangeLatLoninDay < ActiveRecord::Migration
	def self.up
 		change_column :days, :latitude, :decimal
  	change_column :days, :longitude, :decimal
	end
  def self.down
		change_column :days, :latitude, :integer
		change_column :days, :longitude, :integer
  end
end
