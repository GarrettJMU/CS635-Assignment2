module Concerns
  module Arithmetic
    class Number
      attr_accessor :value

      def initialize number
        @value = number
      end

      def execute
        value
      end
    end
  end
end
