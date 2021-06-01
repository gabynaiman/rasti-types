require 'minitest_helper'

describe Rasti::Types::Array do

  VALID_ARRAY = [1, '2', Time.now]
  INVALID_ARRAY = [1, 'text', :symbol, {a: 1, b: 2}, Object.new]

  it 'nil -> nil' do
    Rasti::Types::Array[Rasti::Types::String].cast(nil).must_equal nil
  end

  it '[nil] -> [nil]' do
    Rasti::Types::Array[Rasti::Types::String].cast([nil]).must_equal [nil]
  end

  it "#{VALID_ARRAY.inspect} -> #{VALID_ARRAY.map(&:to_i)}" do
    Rasti::Types::Array[Rasti::Types::Integer].cast(VALID_ARRAY).must_equal VALID_ARRAY.map(&:to_i)
  end

  it "#{VALID_ARRAY.inspect} -> #{VALID_ARRAY.map(&:to_s)}" do
    Rasti::Types::Array[Rasti::Types::String].cast(VALID_ARRAY).must_equal VALID_ARRAY.map(&:to_s)
  end

  INVALID_ARRAY.each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Array[Rasti::Types::String].cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Array[Rasti::Types::String]"
    end
  end

  describe 'Multi cast errors' do

    it 'Array of integers' do
      array = [1, 2 , 'a', 3, 'c', 4]

      error = proc { Rasti::Types::Array[Rasti::Types::Integer].cast(array) }.must_raise Rasti::Types::MultiCastError

      error.errors.must_equal 3 => ["Invalid cast: 'a' -> Rasti::Types::Integer"],
                              5 => ["Invalid cast: 'c' -> Rasti::Types::Integer"]

      error.message.must_equal "Cast errors:\n- 3: [\"Invalid cast: 'a' -> Rasti::Types::Integer\"]\n- 5: [\"Invalid cast: 'c' -> Rasti::Types::Integer\"]"
    end

    it 'Array of models' do
      array = [
        {x: 1, y: 2},
        {y: 2},
        {x: 1},
        {x: 3, y: 4}
      ]

      error = proc { Rasti::Types::Array[Rasti::Types::Model[Point]].cast(array) }.must_raise Rasti::Types::MultiCastError

      error.errors.must_equal '2.x' => ['not present'],
                              '3.y' => ['not present']

      error.message.must_equal "Cast errors:\n- 2.x: [\"not present\"]\n- 3.y: [\"not present\"]"
    end

  end

end