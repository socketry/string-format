# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "string/format"

describe String::Format do
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
end
