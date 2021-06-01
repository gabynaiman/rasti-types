require 'minitest_helper'

describe Rasti::Types::Hash do

  it 'nil -> nil' do
    Rasti::Types::Hash[Rasti::Types::Integer, Rasti::Types::String].cast(nil).must_equal nil
  end

  it '{nil => nil} -> {nil => nil}' do
    Rasti::Types::Hash[Rasti::Types::Integer, Rasti::Types::String].cast(nil => nil).must_equal nil => nil
  end

  it "{'a' => '123'} -> {a: 123}" do
    Rasti::Types::Hash[Rasti::Types::Symbol, Rasti::Types::Integer].cast('a' => '123').must_equal a: 123
  end

  it "{'1' => :abc} -> {1 => 'abc'}" do
    Rasti::Types::Hash[Rasti::Types::Integer, Rasti::Types::String].cast('1' => :abc).must_equal 1 => 'abc'
  end

  [1, 'text', :symbol, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Hash[Rasti::Types::Symbol, Rasti::Types::Integer].cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Hash[Rasti::Types::Symbol, Rasti::Types::Integer]"
    end
  end

  describe 'Multi cast errors' do

    it 'Simple types' do
      value = {
        true => 1,
        2 => false,
        false => true
      }

      error = proc { Rasti::Types::Hash[Rasti::Types::Integer, Rasti::Types::Integer].cast(value) }.must_raise Rasti::Types::MultiCastError

      error.errors.must_equal true => ['Invalid cast: true -> Rasti::Types::Integer'],
                              2 => ['Invalid cast: false -> Rasti::Types::Integer'],
                              false => ['Invalid cast: false -> Rasti::Types::Integer', 'Invalid cast: true -> Rasti::Types::Integer']

      error.message.must_equal "Cast errors:\n- true: [\"Invalid cast: true -> Rasti::Types::Integer\"]\n- 2: [\"Invalid cast: false -> Rasti::Types::Integer\"]\n- false: [\"Invalid cast: false -> Rasti::Types::Integer\", \"Invalid cast: true -> Rasti::Types::Integer\"]"
    end

    it 'Models' do
      value = {
        'a' => {x: 1, y: 2},
        'b' => {x: 1},
        'c' => true
      }

      error = proc { Rasti::Types::Hash[Rasti::Types::String, Rasti::Types::Model[Point]].cast(value) }.must_raise Rasti::Types::MultiCastError

      error.errors.must_equal 'b.y' => ['not present'],
                              'c' => ['Invalid cast: true -> Rasti::Types::Model[Point]']

      error.message.must_equal "Cast errors:\n- b.y: [\"not present\"]\n- c: [\"Invalid cast: true -> Rasti::Types::Model[Point]\"]"
    end

  end
end