module Concerns
  class Arithmetic
    attr_reader :left_operand, :right_operand

    def initialize(left_operand, right_operand)
      @left_operand = left_operand
      @right_operand = right_operand
    end

    def add
      left_operand + right_operand
    end

    def subtract
      left_operand - right_operand
    end

    def multiply
      left_operand * right_operand
    end

    def divide
      left_operand / right_operand
    end

    def sin
      Math.sin(left_operand)
    end

    def log2
      Math.log2(left_operand)
    end

  end
end
