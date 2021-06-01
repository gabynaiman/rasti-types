module Rasti
  module Types
    class Hash

      include Castable

      attr_reader :key_type, :value_type

      def self.[](key_type, value_type)
        new key_type, value_type
      end

      def to_s
        "#{self.class}[#{key_type}, #{value_type}]"
      end
      alias_method :inspect, :to_s

      private

      def initialize(key_type, value_type)
        @key_type = key_type
        @value_type = value_type
      end

      def valid?(value)
        value.is_a? ::Hash
      end

      def transform(value)
        MultiCaster.cast!(self, value) do |multi_caster|
          value.each_with_object({}) do |(k,v), hash|
            casted_key = multi_caster.cast type: key_type,
                                           value: k,
                                           error_key: k

            casted_value = multi_caster.cast type: value_type,
                                             value: v,
                                             error_key: k

            hash[casted_key] = casted_value
          end
        end
      end

    end
  end
end