require 'minitest_helper'

describe Rasti::Types::Enum do

  let(:enum) { Rasti::Types::Enum[:a,:b,:c] }

  it 'nil -> nil' do
    enum.cast(nil).must_be_nil
  end

  [:a, 'b', "c"].each do |value|
    it "#{value.inspect} -> #{value.to_s.inspect}" do
      enum.cast(value).must_equal value.to_s
    end
  end

  ['text', :symbol, '999'.to_sym, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { enum.cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Enum[\"a\", \"b\", \"c\"]"
    end
  end

  it 'Values' do
    enum = Rasti::Types::Enum[:first_value, 'SecondValue', 'THIRD_VALUE']

    enum.first_value.must_equal 'first_value'
    enum.second_value.must_equal 'SecondValue'
    enum.third_value.must_equal 'THIRD_VALUE'
    enum.values.must_equal [enum.first_value, enum.second_value, enum.third_value]
  end

end