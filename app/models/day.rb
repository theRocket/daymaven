class Day < ActiveRecord::Base
  belongs_to :user
  has_one :itinerary
  has_many :activities, :through => :iteneraries
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :users
  
 
  def average_rating
      @value = 0
      self.ratings.each do |rating|
          @value = @value + rating.value
      end
      @total = self.ratings.size
      @avg_value = @value.to_f / @total.to_f
      @avg_value.nan? ? "N/A" : @avg_value
  end
  
  
   def self.search(search, city)
    if search
	 find(:all, :conditions => build_search_query(search, city))
    else
      find(:all)
    end
  end
  
  def self.build_search_query(search, city ) # description (LIKE '<term1>' OR '<term2>') AND location LIKE '<city>'

    array = search.split
    like_conditions = []
    key_count = array.size
    
	#handle no terms
	if key_count > 0
		k = "("
	else
		k = ""
	end
	
    array.each do |value|
      k << "description LIKE '%%#{value}%%'"
      if key_count > 1 
        k += " or "
      end
      key_count -= 1
    end
    
	#AND city query if terms
	if array.size > 0
      k += ") AND "
	end
	
	k += "location LIKE '%%#{city}%%'"
    like_conditions << k

	puts like_conditions
	like_conditions
  end

end
