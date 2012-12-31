require 'spec_helper'
describe Move do
	it "should be able to get listings" do
		listings = Move.get_listings(:distressed => 'foreclosure')['listings']
		listings.count.should be > 4
	end
end