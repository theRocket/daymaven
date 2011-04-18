class AddTypeAndEventDateToDay < ActiveRecord::Migration
  def self.up
  add_column :days, :type, :integer, :default => 1
  add_column :days, :event_date, :datetime
  end

  def self.down
   remove_column :days, :type
   remove_column :days, :event_date
  end
end
