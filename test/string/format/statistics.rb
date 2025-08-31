# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "string/format"

describe String::Format do
	with ".statistics" do
		it "formats single values" do
			result = subject.statistics({connections: 23})
			expect(result).to be == "C=23"
		end
		
		it "formats ratios from arrays" do
			result = subject.statistics({c: [23, 3420]})
			expect(result).to be == "C=23/3.42K"
		end
		
		it "formats multiple statistics" do
			result = subject.statistics({
				c: [23, 3420], 
				r: [2, 3420]
			})
			expect(result).to be == "C=23/3.42K R=2/3.42K"
		end
		
		it "handles mixed statistic types" do
			result = subject.statistics({
				connections: [23, 3420],
				active: 5,
				load: 0.273
			})
			expect(result).to be == "C=23/3.42K A=5 L=0.27"
		end
		
		it "handles arrays with more than 2 elements" do
			result = subject.statistics({multi: [1, 2, 3]})
			expect(result).to be == "M=1/2/3"
		end
		
		it "handles empty statistics" do
			result = subject.statistics({})
			expect(result).to be == ""
		end
		
		it "handles symbol and string keys" do
			result = subject.statistics({
				:symbol_key => 100,
				"string_key" => 200
			})
			expect(result).to be == "S=100 S=200"
		end
		
		it "formats full keys when short=false" do
			result = subject.statistics({connections: 23}, short: false)
			expect(result).to be == "CONNECTIONS=23"
		end
	end
	
	with "real-world examples" do
		it "formats Falcon-style statistics" do
			# Simulating the Falcon use case
			connection_count = 23
			accept_count = 3420
			active_count = 2
			request_count = 3420
			
			statistics = subject.statistics({
				c: [connection_count, accept_count],
				r: [active_count, request_count]
			})
			
			expect(statistics).to be == "C=23/3.42K R=2/3.42K"
		end
		
		it "formats process title information" do
			load_value = 0.273456
			
			formatted_load = subject.decimal(load_value)
			expect(formatted_load).to be == "0.27"
			
			# Simulating full process title
			service_name = "web-server"
			stats = subject.statistics({
				c: [23, 3420],
				r: [2, 3420]
			})
			
			process_title = "#{service_name} (#{stats} L=#{formatted_load})"
			expect(process_title).to be == "web-server (C=23/3.42K R=2/3.42K L=0.27)"
		end
	end
end
