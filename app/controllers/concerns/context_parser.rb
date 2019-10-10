require "observer"

module Concerns
  class ContextParser
    
    def parse(expression, cell, context)
      return if expression.blank?
      stack = []

      expression.lstrip!
      while expression.length > 0
        case expression
        when /\A-?\d+(\.\d+)?/
          stack << ::Concerns::Arithmetic::Number.new($&.to_i)
        when /\A\$A/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[0].value_view)
          context.cells[0].add_observer(cell)
        when /\A\$B/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[1].value_view)
          context.cells[1].add_observer(cell)
        when /\A\$C/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[2].value_view)
          context.cells[2].add_observer(cell)
        when /\A\$D/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[3].value_view)
          context.cells[3].add_observer(cell)
        when /\A\$E/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[4].value_view)
          context.cells[4].add_observer(cell)
        when /\A\$F/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[5].value_view)
          context.cells[5].add_observer(cell)
        when /\A\$G/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[6].value_view)
          context.cells[6].add_observer(cell)
        when /\A\$H/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[7].value_view)
          context.cells[7].add_observer(cell)
        when /\A\$I/
          stack << ::Concerns::Arithmetic::Number.new(context.cells[8].value_view)
          context.cells[8].add_observer(cell)
        else
          case expression
          when /\A\+/
            second, first = stack.pop, stack.pop
            stack << ::Concerns::Arithmetic::Add.new(first, second)
          when /\A\-/
            second, first = stack.pop, stack.pop
            stack << ::Concerns::Arithmetic::Subtract.new(first, second)
          when /\A\*/
            second, first = stack.pop, stack.pop
            stack << ::Concerns::Arithmetic::Multiply.new(first, second)
          when /\A\//
            second, first = stack.pop, stack.pop
            stack << ::Concerns::Arithmetic::Divide.new(first, second)
          when /\Alg/
            first = stack.pop
            stack << ::Concerns::Arithmetic::Log.new(first)
          when /\Asin/
            first = stack.pop
            stack << ::Concerns::Arithmetic::Sin.new(first)
          else
            raise 'Unknown input'
          end
        end

        expression = $'
        expression.lstrip!
      end

      raise 'Syntax error' unless stack.size == 1

      stack.first.execute
    end

  end
end
