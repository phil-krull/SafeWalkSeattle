require 'http'
require "open-uri"

class DirectionsController < ApplicationController
require 'openssl'
	def index
	end
	def create_directions
		@response = []
		@address = [params[:start_address], params[:end_address]]
		session[:address] = @address
		@address.each do |addr|

			uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=" + addr + "&key=AIzaSyAFKDN5CZiPsOBMy4p-TmiuLdI4lX1VWG0")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
			response = http.get(uri.request_uri)
			result = JSON.parse response.body.gsub('=>', ':')
			@response << result
			
		end
		@location = []
		@response.each do |r|
			@location << r["results"][0]["geometry"]["location"]["lat"]
			@location << r["results"][0]["geometry"]["location"]["lng"]
		end

		get_map_directions(@location)

	end

	def get_map_directions location			
		@response = []

		for i in 1..2 do 
			if i == 1
				lat = location[0]
				long = location [1]
			else 
				lat = location[2]
				long = location[3]
			end
			client = SODA::Client.new({:domain => "data.seattle.gov", :app_token => "FPAUb8hq9VkrOUpKXiqAHvi5B"})

	  		data = client.get("y7pv-r3kh", {"$limit" => "1000", "$order" => "date_reported DESC", "$where" => "within_circle(location, " + lat.to_s + "," + long.to_s + "," + " 150) AND offense_type IN('HARASSMENT', 'ASSLT-AGG-GUN', 'ASSLT-NON-AGG', 'ROBBERY-BUSINESS-WEAPON','ASSLT-AGG-BODYFORCE','ROBBERY-STREET-BODYFORCE','ROBBERY-STREET-WEAPON') AND year > 2014"})

	  		@response << data

  		end
  		@results = Hash.new
  		@test = []
  		@response.each do |r|
  			r.each do |s|
  				@results["offense"] = s.summarized_offense_description
  				@results["location"] = s.location.coordinates
  				puts s.summarized_offense_description
  				@test.push(@results)
  			end
  		end

  	
  		render :json => @test
	end
	redirect_to 'test/index'
end
