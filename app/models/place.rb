class Place < ActiveRecord::Base
  has_many :activities
  has_many :days, :through => :activities

end
