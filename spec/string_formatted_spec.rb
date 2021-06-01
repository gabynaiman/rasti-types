require 'minitest_helper'

describe Rasti::Types::String, 'Formatted' do

  let(:email_regexp) { /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  it 'nil -> nil' do
    Rasti::Types::String[email_regexp].cast(nil).must_equal nil
  end

  ['user@mail.com'.to_sym, 'user.name-123@mail-test.com.ar'].each do |value|
    it "#{value.inspect} -> #{value.to_s}" do
      Rasti::Types::String[email_regexp].cast(value).must_equal value.to_s
    end
  end

  ['text', :symbol, '999'.to_sym, [1,2], {a: 1, b: 2}, Object.new, 5].each do |value|
    it "#{value.inspect} -> CastError" do
      error = proc { Rasti::Types::String[email_regexp].cast(value) }.must_raise Rasti::Types::CastError
      error.message.must_equal "Invalid cast: #{as_string(value)} -> Rasti::Types::String[#{as_string(email_regexp)}]"
    end
  end

end