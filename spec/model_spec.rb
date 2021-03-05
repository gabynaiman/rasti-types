require 'minitest_helper'

describe Rasti::Types::Model do

  it 'Class' do
    result = Rasti::Types::Model[Point].cast x: 1, y: 2
    result.must_be_instance_of Point
    result.x.must_equal 1
    result.y.must_equal 2
  end

  [nil, 'text', :symbol, 1, [1,2], {z: 'text'}, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Model[Point].cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> #{Rasti::Types::Model[Point]}"
    end
  end

end