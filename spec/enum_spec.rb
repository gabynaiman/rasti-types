require 'minitest_helper'

describe Rasti::Types::Enum do

  enum = Rasti::Types::Enum[:a,:b,:c]

  [:a, 'b', "c"].each do |value|
    it "#{value.inspect} -> #{enum}" do
      Rasti::Types::Enum[:a,:b,:c].cast(value).must_equal value.to_s
    end
  end

  [nil, 'text', :symbol, '999'.to_sym, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Enum[:a,:b,:c].cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Enum[\"a\", \"b\", \"c\"]"
    end
  end

  it 'Values' do
    enum = Rasti::Types::Enum[:first_value, 'SecondValue', 'THIRD_VALUE']

    enum.first_value.must_equal 'first_value'
    enum.second_value.must_equal 'SecondValue'
    enum.third_value.must_equal 'THIRD_VALUE'
    enum.values.must_equal ['first_value', 'SecondValue', 'THIRD_VALUE']
  end

end