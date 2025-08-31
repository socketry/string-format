# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

module String::Format
	# Format multiple statistics into a compact string.
	# @parameter pairs [Hash] Hash of statistic names to values or [current, total] arrays.
	# @returns [String] A formatted statistics string.
	def statistics(**pairs)
		pairs.map do |key, value|
			case value
			when Array
				value = value.map(&method(:count)).join("/")
			when Numeric
				value = count(value)
			end
			
			"#{key.to_s.upcase}=#{value}"
		end.join(" ")
	end
	
	module_function :statistics
end
