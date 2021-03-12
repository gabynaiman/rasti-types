module Rasti
  module Types
    class TypedEnum

      include Castable

      def self.[](enum)
        new enum
      end

      def initialize(enum)
        @enum = enum
        define_getters
      end

      def values
        enum.values
      end

      def to_s
        "#{self.class}[#{enum}]"
      end
      alias_method :inspect, :to_s

      private

      attr_reader :enum

      def valid?(value)
        enum.include? value
      end

      def transform(value)
        enum[value]
      end

      def define_getters
        values.each do |value|
          define_singleton_method(Inflecto.underscore(value)) { value }
        end
      end

    end
  end
end