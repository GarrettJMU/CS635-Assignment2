module Concerns
  module Arithmetic
    class Divide

      attr_reader :left, :right

      def initialize(left, right)
        @left = left
        @right = right
      end

      def execute
        left.execute.to_f / right.execute.to_f
      end

    end
  end
end
