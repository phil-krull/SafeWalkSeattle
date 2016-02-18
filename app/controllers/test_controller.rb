require 'soda/client'
class TestController < ApplicationController
  def index
    lat = 47.612938
    long = -122.319435
  	client = SODA::Client.new({:domain => "data.seattle.gov", :app_token => "FPAUb8hq9VkrOUpKXiqAHvi5B"})

  	@data = client.get("y7pv-r3kh", {"$limit" => "1000", "$order" => "date_reported DESC", "$where" => "within_circle(location, " + lat.to_s + "," + long.to_s + "," + " 150) AND offense_type IN('HARASSMENT', 'ASSLT-AGG-GUN', 'ASSLT-NON-AGG', 'ROBBERY-BUSINESS-WEAPON','ASSLT-AGG-BODYFORCE','ROBBERY-STREET-BODYFORCE','ROBBERY-STREET-WEAPON') AND year > 2014"})


  	@newdata = @data.to_json
  	# render :json => @newdata
  	puts @newdata

  		@all = []
		@object = {}
		i = 0
  	@data.each do |e| 
  		puts e.offense_type
  		@object[:name] = e.offense_type 
		@all << @object

 	end 






end
