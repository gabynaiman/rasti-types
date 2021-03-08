require 'coverage_helper'
require 'minitest/autorun'
require 'minitest/colorin'
require 'pry-nav'
require 'rasti-types'

module Minitest
  class Test
    def as_string(value)
      value.is_a?(::String) ? "'#{value}'" : value.inspect
    end
  end
end

class Point

  attr_reader :x, :y

  def initialize(attributes={})
    errors = {}

    if attributes.key? :x
      @x = attributes[:x]
    else
      errors[:x] = ['not present']
    end

    if attributes.key? :y
      @y = attributes[:y]
    else
      errors[:y] = ['not present']
    end

    raise Rasti::Types::CompoundError, errors if errors.any?
  end

end