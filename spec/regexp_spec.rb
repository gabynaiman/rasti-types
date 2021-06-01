require 'minitest_helper'

describe Rasti::Types::Regexp do

  it 'nil -> nil' do
    Rasti::Types::Regexp.cast(nil).must_equal nil
  end

  ['[a-z]', /[a-z]/].each do |value|
    it "#{value.inspect} -> #{Regexp.new(value).inspect}" do
      Rasti::Types::Regexp.cast(value).must_equal Regexp.new(value).source
    end
  end

  ['[a-z', :symbol, [1,2], {a: 1, b: 2}, Object.new, 5].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Regexp.cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Regexp"
    end
  end

end