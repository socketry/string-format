# frozen_string_literal: true

require_relative "lib/string/format/version"

Gem::Specification.new do |spec|
	spec.name = "string-format"
	spec.version = String::Format::VERSION
	
	spec.summary = "Formatting utilities for strings."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ["release.cert"]
	spec.signing_key = File.expand_path("~/.gem/release.pem")
	
	spec.homepage = "https://github.com/socketry/string-format"
	
	spec.metadata = {
		"documentation_uri" => "https://socketry.github.io/string-format/",
		"source_code_uri" => "https://github.com/socketry/string-format.git",
	}
	
	spec.files = Dir["{lib}/**/*", "*.md", base: __dir__]
	
	spec.required_ruby_version = ">= 3.2"
end
