require 'minitest_helper'

describe Rasti::Types::Boolean do

  it 'nil -> nil' do
    Rasti::Types::Boolean.cast(nil).must_equal nil
  end

  [true, 'true', 'True', 'TRUE', 'T'].each do |value|
    it "#{value.inspect} -> true" do
      Rasti::Types::Boolean.cast(value).must_equal true
    end
  end

  [false, 'false', 'False', 'FALSE', 'F'].each do |value|
    it "#{value.inspect} -> false" do
      Rasti::Types::Boolean.cast(value).must_equal false
    end
  end

  ['text', 123, :false, :true, Time.now, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Boolean.cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Boolean"
    end
  end

end