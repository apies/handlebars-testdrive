require 'httparty'

class MoveApi
	
	include HTTParty
	
	base_uri 'https://api.move.com/v2'
	attr_accessor :token

	def initialize(user, pass)
		@auth  = {:username => user, :password => pass}
		get_token
	end

	def get_token
		result = self.class.get('/auth/gen/PRO/ssl/real?client_id=jsc', :basic_auth => @auth)
		@token = result['api_token']
	end

	def get_listings(params)
		self.class.get("/listings/search?&api_token=#{@token}&client_id=jsc", params)
	end

end



module ApiWrapper
	
	attr_accessor :token, :move_api
	
	def method_missing(method, *args)
		create_client unless @move_api
		if @move_api.methods.include?(method)
			@move_api.send(method, *args)
		else
			super
		end
	end

	def create_client
		@move_api = MoveApi.new(CONFIG['USERNAME'], CONFIG['PASSWORD'])
	end


end





class Move
	
	extend ApiWrapper
	
end


#m = MoveApi.new(CONFIG['USERNAME'], CONFIG['PASSWORD'])
#puts m.class.get('/auth/gen/PRO/ssl/real?client_id=jsc', :basic_auth => {:username => CONFIG['USERNAME'], :password => CONFIG['PASSWORD']})
#{"api_token"=>"AxZayZaGNfbW9iLzIwMTIxMjMxMDExNTI5pWZbZbjQ0Bd5IZd", "time_to_live"=>86400.0, "meta"=>{"build"=>"2.1.9.2/c0eaa09ee8add6471f85cf476869d5103d56ee32"}}

