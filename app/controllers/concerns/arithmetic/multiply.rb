module Concerns
  module Arithmetic
    class Multiply

      attr_reader :left, :right

      def initialize(left, right)
        @left = left
        @right = right
      end

      def execute
        left.execute * right.execute
      end

    end
  end
end
