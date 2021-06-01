module Rasti
  module Types
    module Castable

      def cast(value)
        return nil if value.nil?

        if valid? value
          transform! value
        else
          raise CastError.new self, value
        end
      end

      private

      def transform!(value)
        transform value
      rescue CompoundError => ex
        raise ex
      rescue
        raise CastError.new self, value
      end

    end
  end
end