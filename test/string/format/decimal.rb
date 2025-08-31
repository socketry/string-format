# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "string/format"

describe String::Format do
	with ".decimal" do
		it "formats decimals to 2 decimal places by default" do
			expect(subject.decimal(0.273)).to be == "0.27"
			expect(subject.decimal(1.0)).to be == "1.0"
			expect(subject.decimal(0.0)).to be == "0.0"
		end
		
		it "handles values greater than 1" do
			expect(subject.decimal(2.5)).to be == "2.5"
			expect(subject.decimal(10.123456)).to be == "10.12"
		end
		
		it "allows custom precision" do
			expect(subject.decimal(1.23456, precision: 3)).to be == "1.235"
			expect(subject.decimal(1.23456, precision: 1)).to be == "1.2"
			expect(subject.decimal(1.23456, precision: 0)).to be == "1"
		end
	end
end
