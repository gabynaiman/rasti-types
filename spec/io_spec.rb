require 'minitest_helper'

describe Rasti::Types::IO do

  [StringIO.new, File.new(__FILE__)].each do |value|
    it "#{value.inspect} -> #{value}" do
      Rasti::Types::IO.cast(value).must_equal value
    end
  end

  [nil, 'text', 123, :symbol, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::IO.cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::IO"
    end
  end

end