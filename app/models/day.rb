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
	  
	def self.search(search, city, pagenum)
		if search
			Day.where(build_search_query(search, city)).order('average_rating DESC').page(pagenum).per(50)
		else
			Day.order('average_rating DESC').page(pagenum).per(50)
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
		  k << "UPPER(description) LIKE UPPER('%%#{value}%%')"
		  if key_count > 1 
			k += " or "
		  end
		  key_count -= 1
		end
		
		#AND city query if terms
		if array.size > 0
		  k += ") AND "
		end
		
		k += "UPPER(location) LIKE UPPER('%%#{city}%%')"
		like_conditions << k
		
		puts like_conditions
		like_conditions
	end  
   
end
