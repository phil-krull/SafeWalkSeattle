require 'soda/client'
class TestsController < ApplicationController
	def index
		client = SODA::Client.new({:domain => "data.seattle.gov", :app_token => "FPAUb8hq9VkrOUpKXiqAHvi5B"})
		@stuff = client.get("y7pv-r3kh", {"$limit" => 1})
	end
end