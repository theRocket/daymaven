class AddLocationToDay < ActiveRecord::Migration
 	def self.up
    add_column :days, :location, :string
  end

  def self.down
    remove_column :days, :location
  end
end
