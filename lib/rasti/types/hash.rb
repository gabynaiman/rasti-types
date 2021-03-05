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
        result = {}
        errors = {}

        value.each do |k,v|
          begin
            result[key_type.cast k] = value_type.cast v
          rescue => error
            errors[k] = [error.message]
          end
        end

        raise MultiCastError.new(self, value, errors) unless errors.empty?

        result
      end

    end
  end
end