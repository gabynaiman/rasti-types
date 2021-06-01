require 'minitest_helper'

describe Rasti::Types::TypedEnum do

  let(:enum) { Rasti::Types::TypedEnum[Colors] }

  it 'nil -> nil' do
    enum.cast(nil).must_equal nil
  end

  ['BLUE', 'GREEN', 'RED'].each do |value|
    it "#{value.inspect} -> #{value}" do
      enum.cast(value).must_equal Colors[value]
    end
  end

  ['text', :symbol, true, false, 100, Time.now, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { enum.cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::TypedEnum[Colors]"
    end
  end

  it 'Values' do
    enum.blue.must_equal Colors::Blue.new
    enum.green.must_equal Colors::Green.new
    enum.red.must_equal Colors::Red.new
    enum.values.must_equal [enum.blue, enum.green, enum.red]
  end

end