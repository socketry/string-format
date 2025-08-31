# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

describe String::Format do
	it "has a version number" do
		expect(String::Format::VERSION).to be =~ /^\d+\.\d+\.\d+$/
	end
end
