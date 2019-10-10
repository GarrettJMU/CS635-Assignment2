module Concerns
  class Spreadsheet

    attr_accessor :current_view, :cells, :state

    def initialize(state)
      @cells = []
      @current_view = 'Value'

      1..9.times { @cells.push(SpreadsheetCell.new) }
      transition_to(state)
    end

    def transition_to(state)
      @state = state
      @state.context = self
      @current_view = @state.value
    end

    def handle_value_view(index = nil, value = nil)
      @state.handle_value_view(index, value)
    end

    def handle_equation_view(index = nil, value = nil, parsed = nil)
      @cells[index].delete_observers if index.present?
      parsed_value = parse(value, index)

      @state.handle_equation_view(index, parsed_value, value)
    end

    def parse(context, index)
      return if context.blank?

      stack = []

      context.lstrip!
      while context.length > 0
        case context
        when /\A-?\d+(\.\d+)?/
          stack << ::Concerns::Arithmetic::Number.new($&.to_i)
        when /\A\$A/
          stack << ::Concerns::Arithmetic::Number.new(@cells[0].value_view)
          @cells[index].add_observer(@cells[0])
        when /\A\$B/
          stack << ::Concerns::Arithmetic::Number.new(@cells[1].value_view)
          @cells[index].add_observer(@cells[1])
        when /\A\$C/
          stack << ::Concerns::Arithmetic::Number.new(@cells[2].value_view)
          @cells[index].add_observer(@cells[2])
        when /\A\$D/
          stack << ::Concerns::Arithmetic::Number.new(@cells[3].value_view)
          @cells[index].add_observer(@cells[3])
        when /\A\$E/
          stack << ::Concerns::Arithmetic::Number.new(@cells[4].value_view)
          @cells[index].add_observer(@cells[4])
        when /\A\$F/
          stack << ::Concerns::Arithmetic::Number.new(@cells[5].value_view)
          @cells[index].add_observer(@cells[5])
        when /\A\$G/
          stack << ::Concerns::Arithmetic::Number.new(@cells[6].value_view)
          @cells[index].add_observer(@cells[6])
        when /\A\$H/
          stack << ::Concerns::Arithmetic::Number.new(@cells[7].value_view)
          @cells[index].add_observer(@cells[7])
        when /\A\$I/
          stack << ::Concerns::Arithmetic::Number.new(@cells[8].value_view)
          @cells[index].add_observer(@cells[8])
        else
          case context
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

        context = $'
        context.lstrip!
      end

      raise 'Syntax error' unless stack.size == 1

      stack.first.execute
    end

  end
end
