class LocationsController < ApplicationController

def index
	loc = GeoKit::Geocoders::MultiGeocoder.geocode(params[:term])
	render :text => loc.all.collect{|e|  {:value => e.full_address, :lat => e.lat, :lng => e.lng }}.to_json
	end
end


