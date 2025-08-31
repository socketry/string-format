# Getting Started

This guide explains how to get started with `string-format` to format numbers, ratios, and strings for display purposes.

## Installation

Add the gem to your project:

```bash
$ bundle add string-format
```

## Core Concepts

`string-format` provides several formatting utilities through the {String::Format} module:

- {String::Format.count} for formatting numbers with human-readable units (K, M, B, etc.).
- {String::Format.ratio} for displaying ratios like "23/3.42K".
- {String::Format.decimal} for consistent decimal formatting.
- {String::Format.title_case} for converting strings to Title Case.
- {String::Format.snake_case} for converting strings to snake_case.
- {String::Format.statistics} for formatting collections of statistics.

## Usage

All methods are available as module functions on {String::Format}:

```ruby
require 'string/format'

# Format large numbers with units
String::Format.count(1500)     # => "1.5K"
String::Format.count(2340000)  # => "2.34M"

# Format decimal values
String::Format.decimal(0.273, precision: 2)  # => "0.27"
String::Format.decimal(1.23456, precision: 3)  # => "1.235"

# Convert string cases
String::Format.title_case("hello_world")  # => "Hello World"
String::Format.snake_case("CamelCase")    # => "camel_case"
```

### Formatting Statistics

The {String::Format.statistics} method is particularly useful for creating compact status displays:

```ruby
# Format individual statistics
String::Format.statistics({connections: 42})  # => "C=42"

# Format ratios using arrays
String::Format.statistics(
  connections: [23, 3420],
  requests: [156, 3420]
)
# => "C=23/3.42K R=156/3.42K"

# Mix different value types
String::Format.statistics({
  connections: [23, 3420],
  active: 5,
  load: 0.273
})
# => "C=23/3.42K A=5 L=0.27"
```

### Process Title Formatting

This gem is particularly useful for creating informative process titles in services:

```ruby
service_name = "web-server"
stats = String::Format.statistics(
  c: [23, 3420],    # connections
  r: [2, 3420]      # requests  
)
load_avg = String::Format.decimal(0.273)

process_title = "#{service_name} (#{stats} L=#{load_avg})"
# => "web-server (C=23/3.42K R=2/3.42K L=0.27)"

# Set the process title
Process.setproctitle(process_title)
```

### Custom Units

You can provide custom units for the {String::Format.count} method:

```ruby
# Use lowercase units
custom_units = [nil, "k", "m", "b"]
String::Format.count(1500, custom_units)  # => "1.5k"

# Limit to specific units
limited_units = [nil, "K"]
String::Format.count(1000000, limited_units)  # => "1000.0K"
```
