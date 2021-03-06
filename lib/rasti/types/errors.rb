module Rasti
  module Types

    class CastError < StandardError

      attr_reader :type, :value

      def initialize(type, value)
        @type = type
        @value = value

        super "Invalid cast: #{display_value} -> #{type}"
      end

      private

      def display_value
        value.is_a?(::String) ? "'#{value}'" : value.inspect
      end

    end

    class CompoundError < StandardError

      attr_reader :errors

      def initialize(errors)
        @errors = errors
        super "#{message_title}\n#{message_lines}"
      end

      private

      def message_title
        'Errors:'
      end

      def message_lines
        errors.map { |k,v| "- #{k}: #{v}" }.join("\n")
      end

    end

    class MultiCastError < CompoundError

      attr_reader :type, :value

      def initialize(type, value, errors)
        @type = type
        @value = value
        super errors
      end

      private

      def message_title
        'Cast errors:'
      end

    end

  end
end