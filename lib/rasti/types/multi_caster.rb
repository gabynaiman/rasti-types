module Rasti
  module Types
    class MultiCaster

      def self.cast!(type, value)
        multi_caster = new type, value
        result = yield multi_caster
        multi_caster.raise_if_error!
        result
      end

      def initialize(type, value)
        @type = type
        @value = value
        @errors = ::Hash.new { |h,k| h[k] = [] }
      end

      def cast(type:, value:, error_key:)
        type.cast value

      rescue CompoundError => ex
        ex.errors.each do |inner_error_key, messages|
          errors["#{error_key}.#{inner_error_key}"] += messages
        end

      rescue => ex
        errors[error_key] << ex.message
      end

      def raise_if_error!
        raise MultiCastError.new(type, value, errors) unless errors.empty?
      end

      private

      attr_reader :type, :value, :errors

    end
  end
end