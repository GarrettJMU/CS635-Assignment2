module Concerns
  module Arithmetic
    class Log

      attr_reader :left

      def initialize(left)
        @left = left
      end

      def execute
        Math.log2(left.execute)
      end

    end
  end
end
