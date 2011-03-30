class Activity < ActiveRecord::Base
  belongs_to :day
  belongs_to :place
  
end
