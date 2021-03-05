module Rasti
  module Types

    class CastError < StandardError

      attr_reader :type, :value

      def initialize(type, value)
        @type = type
        @value = value
      end

      def message
        "Invalid cast: #{display_value} -> #{type}"
      end

      private

      def display_value
        value.is_a?(::String) ? "'#{value}'" : value.inspect
      end

    end

    class MultiCastError < StandardError

      attr_reader :type, :value, :errors

      def initialize(type, value, errors)
        @type = type
        @value = value
        @errors = errors
      end

      def message
        lines = ['Cast errors:']

        errors.each do |key, value|
          lines << "- #{key}: #{value}"
        end

        lines.join("\n")
      end

    end

  end
end