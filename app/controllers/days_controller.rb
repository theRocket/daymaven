class DaysController < ApplicationController
  helper :all

  before_filter :authenticate_user!, :except => [:index,:show, :search]

    # GET /days
    # GET /days.xml
    def index
  	@days = search(params[:search], params[:city], params[:page])

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @days }
      end
    end

    # GET /days/1
    # GET /days/1.xml
    def show
      @day = Day.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @day }
      end
    end

    # GET /days/new
    # GET /days/new.xml
    def new
      @day = Day.new

       @user = User.find(current_user);
  	    @day.user_id = @user.id
		@day.average_rating = 3

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @day }
      end
	 
    end

    # GET /days/1/edit
    def edit
      @day = Day.find(params[:id])
    end

    # POST /days
    # POST /days.xml
    def create
      @day = Day.new(params[:day])
        @user = User.find(current_user);
  			    @day.user_id = @user.id


      respond_to do |format|
        if @day.save
          format.html { redirect_to(@day, :notice => 'Day was successfully created.') }
		  
		  if (params[:post_to_fb] == '1')
			@user.facebook.feed!(
			:message => @day.user.name + ' has posted a new day to Daymaven',
			 :link => url_for(@day),
			 :picture => 'http://www.daymaven.com/images/daymavensmall.gif',
			:name => @day.title,
			:description => @day.description[0, 80] + '...')
		  end
	  
          format.xml  { render :xml => @day, :status => :created, :location => @day }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @day.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /days/1
    # PUT /days/1.xml
    def update
      @day = Day.find(params[:id])

      respond_to do |format|
        if @day.update_attributes(params[:day])
          format.html { redirect_to(@day, :notice => 'Day was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @day.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /days/1
    # DELETE /days/1.xml
    def destroy
      @day = Day.find(params[:id])
      @day.destroy

      respond_to do |format|
        format.html { redirect_to(days_url) }
        format.xml  { head :ok }
      end
    end
	
	def search(search, city, pagenum)
    if search
		Day.where(build_search_query(search, city)).order('average_rating DESC').page(pagenum).per(50)
    else
		Day.order('average_rating DESC').page(pagenum).per(50)
    end
  end
  
  def build_search_query(search, city ) # description (LIKE '<term1>' OR '<term2>') AND location LIKE '<city>'

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
