class Day < ActiveRecord::Base
  belongs_to :user
  has_one :itinerary
  has_many :activities, :through => :iteneraries
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :users
  
  searchable do
    text :title, :default_boost => 2
    text :description
  end
  
  def self.start_search(search)
    if search
      find(:all, :conditions => ['description LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def average_rating
      @value = 0
      self.ratings.each do |rating|
          @value = @value + rating.value
      end
      @total = self.ratings.size
      @avg_value = @value.to_f / @total.to_f
      @avg_value.nan? ? "N/A" : @avg_value
  end
end
