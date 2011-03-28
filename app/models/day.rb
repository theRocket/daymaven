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
  
   def self.to_like_conditions( name, search )

    array = search.split
    like_conditions = []
    key_count = array.size
    k = ""
    array.each do |value|
      k += "#{name} LIKE ?"
      if key_count > 1 
        k += " or "
      end
      key_count -= 1
    end
    like_conditions << k

    array.each do |value| 
      like_conditions << "%#{value}%"
    end
	
	like_conditions
  end
  
   def self.search(search, city)
    if search
	 #find(:all, :conditions => ['description LIKE ? and location LIKE ?', %search%, %city%])
	
	str = to_like_conditions('description', search)
	  find(:all, :conditions => (str))
	  #'description LIKE ? and location LIKE ?', "%#{city}%"])
	 
	#find (:all, :conditions => ['description like ?', #{search}])
	#str)
	
	#:conditions => to_like_conditions(description, city))
  
	  
	    #find (:all, :conditions => { :descrip => ["Bob", "Steve", "Fred"] }

	 #"%#{search}%"], ['location LIKE ?', c]})
    else
      find(:all)
    end
  end
  

end
