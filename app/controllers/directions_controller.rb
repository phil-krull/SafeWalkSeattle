require 'http'
require "open-uri"

class DirectionsController < ApplicationController
require 'openssl'
	def index
	end
	def create_directions
		@response = []
		@address = [params[:start_address], params[:end_address]]
		@address.each do |addr|

			uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=" + addr + "&key=AIzaSyAFKDN5CZiPsOBMy4p-TmiuLdI4lX1VWG0")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
			response = http.get(uri.request_uri)
			result = JSON.parse response.body.gsub('=>', ':')
			@response << result
			
		end
		# session[:locations] = @response
		session[:locations] = []
		@response.each do |r|
			session[:locations]<< r["results"][0]["geometry"]["location"]["lat"]
			session[:locations]<< r["results"][0]["geometry"]["location"]["lng"]
		end
	
	end

	def create_place
	end
end
