module Concerns
  module Arithmetic
    class Number
      attr_accessor :value

      def initialize number
        @value = number
      end

      def execute
        value.to_f
      end
    end
  end
end
