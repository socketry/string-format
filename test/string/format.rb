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
	
	with ".title_case" do
		it "converts strings to title case" do
			expect(subject.title_case("hello world")).to be == "Hello World"
			expect(subject.title_case("hello-world")).to be == "Hello World"
			expect(subject.title_case("hello_world")).to be == "Hello World"
		end
		
		it "handles mixed delimiters" do
			expect(subject.title_case("hello-world_test case")).to be == "Hello World Test Case"
		end
		
		it "strips leading and trailing whitespace" do
			expect(subject.title_case("  hello world  ")).to be == "Hello World"
		end
		
		it "handles empty strings" do
			expect(subject.title_case("")).to be == ""
		end
	end
	
	with ".snake_case" do
		it "converts camelCase to snake_case" do
			expect(subject.snake_case("CamelCase")).to be == "camel_case"
			expect(subject.snake_case("XMLHttpRequest")).to be == "xml_http_request"
		end
		
		it "handles module separators" do
			expect(subject.snake_case("Async::Service::Formatting")).to be == "async_service_formatting"
		end
		
		it "removes leading underscores" do
			expect(subject.snake_case("_TestCase")).to be == "test_case"
		end
		
		it "handles already snake_case strings" do
			expect(subject.snake_case("already_snake_case")).to be == "already_snake_case"
		end
		
		it "handles empty strings" do
			expect(subject.snake_case("")).to be == ""
		end
	end
	
	with ".statistics" do
		it "formats single values" do
			result = subject.statistics(connections: 23)
			expect(result).to be == "CONNECTIONS=23"
		end
		
		it "formats ratios from arrays" do
			result = subject.statistics(c: [23, 3420])
			expect(result).to be == "C=23/3.42K"
		end
		
		it "formats multiple statistics" do
			result = subject.statistics(
				c: [23, 3420], 
				r: [2, 3420]
			)
			expect(result).to be == "C=23/3.42K R=2/3.42K"
		end
		
		it "handles mixed statistic types" do
			result = subject.statistics(
				connections: [23, 3420],
				active: 5,
				load: 0.273
			)
			expect(result).to be == "CONNECTIONS=23/3.42K ACTIVE=5 LOAD=0.27"
		end
		
		it "handles arrays with more than 2 elements" do
			result = subject.statistics(multi: [1, 2, 3])
			expect(result).to be == "MULTI=1/2/3"
		end
		
		it "handles empty statistics" do
			result = subject.statistics()
			expect(result).to be == ""
		end
		
		it "handles symbol and string keys" do
			result = subject.statistics(
				:symbol_key => 100,
				"string_key" => 200
			)
			expect(result).to be == "SYMBOL_KEY=100 STRING_KEY=200"
		end
	end
	
	with "real-world examples" do
		it "formats Falcon-style statistics" do
			# Simulating the Falcon use case
			connection_count = 23
			accept_count = 3420
			active_count = 2
			request_count = 3420
			
			statistics = subject.statistics(
				c: [connection_count, accept_count],
				r: [active_count, request_count]
			)
			
			expect(statistics).to be == "C=23/3.42K R=2/3.42K"
		end
		
		it "formats process title information" do
			load_value = 0.273456
			
			formatted_load = subject.decimal(load_value)
			expect(formatted_load).to be == "0.27"
			
			# Simulating full process title
			service_name = "web-server"
			stats = subject.statistics(
				c: [23, 3420],
				r: [2, 3420]
			)
			
			process_title = "#{service_name} (#{stats} L=#{formatted_load})"
			expect(process_title).to be == "web-server (C=23/3.42K R=2/3.42K L=0.27)"
		end
	end
end
