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
    @x = attributes.fetch(:x)
    @y = attributes.fetch(:y)
  end

end