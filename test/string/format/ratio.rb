# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "string/format"

describe String::Format do
	with ".ratio" do
		it "formats ratios with appropriate units" do
			expect(subject.ratio(23, 3420)).to be == "23/3.42K"
			expect(subject.ratio(2, 3420)).to be == "2/3.42K"
		end
		
		it "handles large ratios" do
			expect(subject.ratio(1500000, 2340000000)).to be == "1.5M/2.34B"
		end
		
		it "handles small ratios" do
			expect(subject.ratio(5, 100)).to be == "5/100"
		end
		
		it "handles zero values" do
			expect(subject.ratio(0, 1000)).to be == "0/1.0K"
			expect(subject.ratio(100, 0)).to be == "100/0"
		end
	end
end
