require 'spec_helper'

describe ApiWrapper do
	
	before :each do
		@object = Object.new
		@object.extend(ApiWrapper)
		MoveApiMock = MoveApi.new('username', 'secret')
		MoveApiMock.stub(:get_token).and_return('JL380CLNK80NLK32')
		MoveApi.stub(:new).and_return(MoveApiMock)
	end

	it "should know to create a new client for retrieving http listings" do
		MoveApi.should_receive(:new).with(CONFIG['USERNAME'], CONFIG['PASSWORD'])
		@object.get_listings(:city => 'Santa Clara')
	end

	it "should pass the get listings method to the api worker" do
		MoveApiMock.should_receive(:get_listings)
		@object.get_listings(:city => 'Santa Clara')		
	end

end