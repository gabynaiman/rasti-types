require 'minitest_helper'

describe Rasti::Types::Float do

  [100, '200', Time.now,2.0,"12.5"].each do |value|
    it "#{value.inspect} -> #{value.to_i}" do
      Rasti::Types::Float.cast(value).must_equal value.to_f
    end
  end

  [nil, 'text', :symbol, '999'.to_sym, [1,2], {a: 1, b: 2}, Object.new, "1.", ".2","."].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Float.cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Float"
    end
  end

end