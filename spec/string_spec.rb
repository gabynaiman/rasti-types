require 'minitest_helper'

describe Rasti::Types::String do

  ['text', :symbol, true, false, 100, Time.now, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> \"#{value.to_s}\"" do
      Rasti::Types::String.cast(value).must_equal value.to_s
    end
  end

  it 'nil -> CastError' do
    error = proc { Rasti::Types::String.cast(nil) }.must_raise Rasti::Types::CastError
    error.message.must_equal 'Invalid cast: nil -> Rasti::Types::String'
  end

end