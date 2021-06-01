require 'minitest_helper'

describe Rasti::Types::Symbol do

  it 'nil -> nil' do
    Rasti::Types::Symbol.cast(nil).must_equal nil
  end

  ['text', :symbol, true, false, 100, Time.now, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> \"#{value.to_s.to_sym}\"" do
      Rasti::Types::Symbol.cast(value).must_equal value.to_s.to_sym
    end
  end

end