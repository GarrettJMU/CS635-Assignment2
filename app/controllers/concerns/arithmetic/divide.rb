module Concerns
  module Arithmetic
    class Divide

      attr_reader :left, :right

      def initialize(left, right)
        @left = left
        @right = right
      end

      def execute
        left / right
      end

    end
  end
end