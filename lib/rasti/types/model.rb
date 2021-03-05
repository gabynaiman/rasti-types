module Rasti
  module Types
    class Model

      include Castable

      attr_reader :model

      def self.[](model)
        new(model)
      end

      def to_s
        "#{self.class}[#{model}]"
      end
      alias_method :inspect, :to_s

      private

      def initialize(model)
        @model = model
      end

      def valid?(value)
        value.is_a? ::Hash
      end

      def transform(value)
        model.new value
      end

    end
  end
end