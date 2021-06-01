require 'minitest_helper'

describe Rasti::Types::Time do

  TIME = Time.new 2016, 8, 18

  it 'nil -> nil' do
    Rasti::Types::Time['%F %T %z'].cast(nil).must_equal nil
  end

  it "#{TIME.inspect} -> #{TIME.inspect}" do
    Rasti::Types::Time['%F %T %z'].cast(TIME).must_equal TIME
  end

  ['%d/%m/%y', '%Y-%m-%d'].each do |format|
    time_string = TIME.strftime(format)
    it "#{time_string.inspect} -> #{TIME.inspect}" do
      Rasti::Types::Time[format].cast(time_string).must_equal TIME
    end
  end

  [TIME.strftime('%d/%m/%y'), 'text', 1, :symbol, [1,2], {a: 1, b: 2}, Object.new].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::Time['%F'].cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::Time['%F']"
    end
  end

end