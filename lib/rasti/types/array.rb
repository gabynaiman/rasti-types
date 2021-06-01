module Rasti
  module Types
    class Array

      include Castable

      attr_reader :type

      def self.[](type)
        new type
      end

      def to_s
        "#{self.class}[#{type}]"
      end
      alias_method :inspect, :to_s

      private

      def initialize(type)
        @type = type
      end

      def valid?(value)
        value.is_a? ::Array
      end

      def transform(value)
        MultiCaster.cast!(self, value) do |multi_caster|
          value.map.with_index do |e,i|
            multi_caster.cast type: type,
                              value: e,
                              error_key: i+1
          end
        end
      end

    end
  end
end