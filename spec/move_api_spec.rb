require 'spec_helper'
describe MoveApi do

	before :each do
		@move_api = MoveApi.new(CONFIG['USERNAME'], CONFIG['PASSWORD'])
	end


	it 'should have the move.com base uri as its uri base' do
		MoveApi.base_uri.should eq 'https://api.move.com/v2'
	end

	it "should start life by requesting a token" do
		@move_api.token.should match(/\w{10}/)
	end

	it "should be able query for listings in the city of Santa Clara do" do
		listings = @move_api.get_listings(:city => 'Santa Clara')['listings']
		listings.count.should be > 1
	end

	it "should be able query for foreclosures" do
		listings = @move_api.get_listings(:distressed => 'foreclosure')['listings']
		listings.count.should be > 1
	end

	it "should be able query for open houses" do
		listings = @move_api.get_listings(:open_house_date_min => '1-1-2012')['listings']
		listings.count.should be > 9
	end



end
