module Concerns
  module Arithmetic
    class Sin

      attr_reader :left

      def initialize(left)
        @left = left
      end

      def execute
        Math.log2(left)
      end

    end
  end
end
