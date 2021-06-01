require 'minitest_helper'

describe Rasti::Types::Model do

  it 'nil -> nil' do
    Rasti::Types::Model[Point].cast(nil).must_equal nil
  end

  it 'Hash' do
    result = Rasti::Types::Model[Point].cast x: 1, y: 2
    result.must_be_instance_of Point
    result.x.must_equal 1
    result.y.must_equal 2
  end

  it 'Model' do
    model = Point.new x: 3, y: 4
    result = Rasti::Types::Model[Point].cast model
    result.must_equal model
  end

  it 'Hash -> CastError' do
    error = proc { Rasti::Types::Model[Point].cast(z: 'text') }.must_raise Rasti::Types::CompoundError
    error.message.must_equal "Errors:\n- x: [\"not present\"]\n- y: [\"not present\"]"
  end

  ['text', :symbol, 1, [1,2], Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Model[Point].cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> #{Rasti::Types::Model[Point]}"
    end
  end

end