require 'soda/client'
class TestController < ApplicationController
  def index
  	client = SODA::Client.new({:domain => "data.seattle.gov", :app_token => "FPAUb8hq9VkrOUpKXiqAHvi5B"})
  	@data = client.get("y7pv-r3kh", {"$limit" => 1})
  	# render :json => @data
  end
end
