require 'spec_helper'
describe Move do
	it "should be able to get listings" do
		listings = Move.get_listings(:city => 'Santa Clara')['listings']
		listings.count.should be 10
		listings.first['address']['city'].should eq 'Santa Clara'
		listings.last['address']['city'].should eq 'Santa Clara'
	end
end