class Activity < ActiveRecord::Base
  has_many :itineraries
  has_many :days, :through => :itineraries
end
