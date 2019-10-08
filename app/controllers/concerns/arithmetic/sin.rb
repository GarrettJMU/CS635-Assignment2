module Concerns
  module Arithmetic
    class Sin

      attr_reader :left

      def initialize(left)
        @left = left
      end

      def execute
        Math.sin(left)
      end

    end
  end
end
