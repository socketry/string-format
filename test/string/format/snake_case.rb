# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "string/format"

describe String::Format do
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
end
