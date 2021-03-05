# Rasti::Types

[![Gem Version](https://badge.fury.io/rb/rasti-types.svg)](https://rubygems.org/gems/rasti-types)
[![Build Status](https://travis-ci.org/gabynaiman/rasti-types.svg?branch=master)](https://travis-ci.org/gabynaiman/rasti-types)
[![Coverage Status](https://coveralls.io/repos/github/gabynaiman/rasti-types/badge.svg?branch=master)](https://coveralls.io/github/gabynaiman/rasti-types?branch=master)
[![Code Climate](https://codeclimate.com/github/gabynaiman/rasti-types.svg)](https://codeclimate.com/github/gabynaiman/rasti-types)

Type casting

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rasti-types'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rasti-types

## Usage

```ruby
T = Rasti::Types
```

### Type casting

```ruby
T::Integer.cast '10'   # => 10
T::Integer.cast '10.5' # => 10
T::Integer.cast 'text' # => Rasti::Types::CastError: Invalid cast: 'text' -> Rasti::Types::Integer

T::Boolean.cast 'true'  # => true
T::Boolean.cast 'FALSE' # => false
T::Boolean.cast 'text'  # => Rasti::Types::CastError: Invalid cast: 'text' -> Rasti::Types::Boolean

T::Time['%Y-%m-%d'].cast '2016-10-22' # => 2016-10-22 00:00:00 -0300
T::Time['%Y-%m-%d'].cast '2016-10'    # => Rasti::Types::CastError: Invalid cast: '2016-10' -> Rasti::Types::Time['%Y-%m-%d']

T::Array[T::Symbol].cast [1, 'test', :sym] # => [:"1", :test, :sym]
```

### Built-in types

- Array
- Boolean
- Enum
- Float
- Hash
- Integer
- IO
- Model
- Regexp
- String
- Symbol
- Time
- UUID

### Plugable types

```ruby
class UpcaseString
  class << self

    extend Castable

    private

    def valid?(value)
      valid.is_a?(String)
    end

    def transform(value)
      value.upcase
    end

  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/rasti-types.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

