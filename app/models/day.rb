class Day < ActiveRecord::Base
  belongs_to :user
  has_many :activities
  has_many :places, :through => :activities
  has_many :comments
  has_many :commenters, :through => :comments, :source => :users
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :users
  
  validates :title,  :presence => true,
                      :length => { :minimum => 5 }
  validates :description, :presence => true,
                      :length => { :minimum => 20 }

  def determine_average_rating
      @value = 0
      self.ratings.each do |rating|
          @value = @value + rating.value
      end
      @total = self.ratings.size
      @avg_value = @value.to_f / @total.to_f
	  if (not @avg_value.nan?)
		self.average_rating = @avg_value
	  else
		self.average_rating = 3
	  end
     self.save
  end
  
  
   

end
