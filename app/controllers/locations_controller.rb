class LocationsController < ApplicationController

def index
	loc = GeoKit::Geocoders::MultiGeocoder.geocode(params[:term])
	render :text => loc.all.collect{|e| e.full_address }.to_json
	end
end


