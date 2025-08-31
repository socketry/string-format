# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "string/format"

describe String::Format do
	with ".count" do
		it "formats small numbers without units" do
			expect(subject.count(0)).to be == "0"
			expect(subject.count(0.0)).to be == "0.0"
			
			expect(subject.count(1)).to be == "1"
			expect(subject.count(1.0)).to be == "1.0"
			
			expect(subject.count(999)).to be == "999"
		end
		
		it "formats thousands with K unit" do
			expect(subject.count(1000)).to be == "1.0K"
			expect(subject.count(1500)).to be == "1.5K"
			expect(subject.count(999999)).to be == "1000.0K"
		end
		
		it "formats millions with M unit" do
			expect(subject.count(1000000)).to be == "1.0M"
			expect(subject.count(1500000)).to be == "1.5M"
			expect(subject.count(2340000)).to be == "2.34M"
		end
		
		it "formats billions with B unit" do
			expect(subject.count(1000000000)).to be == "1.0B"
			expect(subject.count(1500000000)).to be == "1.5B"
		end
		
		it "formats trillions with T unit" do
			expect(subject.count(1000000000000)).to be == "1.0T"
			expect(subject.count(1500000000000)).to be == "1.5T"
		end
		
		it "handles very large numbers" do
			expect(subject.count(1000000000000000)).to be == "1.0P"
			expect(subject.count(1000000000000000000)).to be == "1.0E"
		end
		
		it "rounds to 2 decimal places" do
			expect(subject.count(1234)).to be == "1.23K"
			expect(subject.count(1235)).to be == "1.24K" # Rounds up
			expect(subject.count(1999)).to be == "2.0K"
		end
		
		it "handles decimal inputs" do
			expect(subject.count(1500.5)).to be == "1.5K"
			expect(subject.count(1234.567)).to be == "1.23K"
		end
		
		it "handles negative numbers" do
			expect(subject.count(-1000)).to be == "-1.0K"
			expect(subject.count(-1234567)).to be == "-1.23M"
		end
		
		with "custom units" do
			it "uses custom unit arrays" do
				custom_units = [nil, "k", "m"]
				expect(subject.count(1000, custom_units)).to be == "1.0k"
				expect(subject.count(1000000, custom_units)).to be == "1.0m"
			end
			
			it "stops at the last unit for very large numbers" do
				custom_units = [nil, "K"]
				expect(subject.count(1000000, custom_units)).to be == "1000.0K"
			end
			
			it "handles empty units array" do
				expect(subject.count(1000, [])).to be == "1000"
			end
			
			it "handles single nil unit" do
				expect(subject.count(1000, [nil])).to be == "1000"
			end
		end
		
		with "custom scale" do
			it "uses binary scale (1024) for file sizes" do
				binary_units = [nil, "KiB", "MiB", "GiB"]
				expect(subject.count(1024, binary_units, scale: 1024)).to be == "1.0KiB"
				expect(subject.count(2048, binary_units, scale: 1024)).to be == "2.0KiB"
				expect(subject.count(1048576, binary_units, scale: 1024)).to be == "1.0MiB"
			end
			
			it "uses custom scale for time units" do
				time_units = [nil, "min", "hr"]
				expect(subject.count(60, time_units, scale: 60)).to be == "1.0min"
				expect(subject.count(3600, time_units, scale: 60)).to be == "1.0hr"
			end
		end
	end
end
