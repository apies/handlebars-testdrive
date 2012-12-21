require 'httparty'




module ApiWrapper
	
	attr_accessor :token, :move_api
	
	def method_missing(method, *args)
		get_token unless @move_api
		if @move_api.methods.include?(method)
			@move_api.send(method, *args)
		else
			super
		end
	end

	def get_token
		@move_api = MoveApi.new(CONFIG['USERNAME'], CONFIG['PASSWORD'])
    @token = @move_api.get_token
	end


end





class MoveApi
	
	include HTTParty
	extend ApiWrapper
	base_uri 'https://api.move.com/v2'
	attr_accessor :token

	def initialize(user, pass)
		@auth  = {:username => user, :password => pass}
	end

	def get_token
		result = self.class.get('/auth/gen/PRO/ssl/real?client_id=jsc', :basic_auth => @auth)
		@token = result['api_token']
	end

	def get_listings
		self.class.get("/listings/search?city=Santa%20Clara&api_token=#{@token}&client_id=jsc")
	end

end


# result = MoveApi.get_listings
# puts result.to_hash


