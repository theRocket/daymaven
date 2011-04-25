class FixTypeInDay < ActiveRecord::Migration
  def self.up
    remove_column :days, :type
	add_column :days, :day_type, :integer, :default => 1
  end

  def self.down
    remove_column :days, :day_type
	add_column :days, :type
  end
end
