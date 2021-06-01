module Rasti
  module Types
    class Enum

      include Castable

      attr_reader :values

      def self.[](*values)
        new values
      end

      def to_s
        "#{self.class}[#{values.map(&:inspect).join(', ')}]"
      end
      alias_method :inspect, :to_s

      private

      def initialize(values)
        @values = values.map(&:to_s)
        define_getters
      end

      def valid?(value)
        values.include? String.cast(value)
      end

      def transform(value)
        String.cast value
      end

      def define_getters
        values.each do |value|
          define_singleton_method(Inflecto.underscore(value)) { value }
        end
      end

    end
  end
end