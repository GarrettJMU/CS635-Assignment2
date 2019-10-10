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

    def handle_equation_view(index = nil, value = nil)
      parsed_value = parse(value)
      @state.handle_equation_view(index, parsed_value)
    end

    def parse(context)
      return if context.blank?

      stack = []

      context.lstrip!
      while context.length > 0
        case context
        when /\A-?\d+(\.\d+)?/
          stack << ::Concerns::Arithmetic::Number.new($&.to_i)
        when /\A\$A/
          puts '###########################'
          puts @cells[0].inspect
          puts '###########################'
          stack << ::Concerns::Arithmetic::Number.new(@cells[0].value_view)
        when /\A\$B/
          stack << ::Concerns::Arithmetic::Number.new(@cells[1].value_view)
        when /\A\$C/
          stack << ::Concerns::Arithmetic::Number.new(@cells[2].value_view)
        when /\A\$D/
          stack << ::Concerns::Arithmetic::Number.new(@cells[3].value_view)
        when /\A\$E/
          stack << ::Concerns::Arithmetic::Number.new(@cells[4].value_view)
        when /\A\$F/
          stack << ::Concerns::Arithmetic::Number.new(@cells[5].value_view)
        when /\A\$G/
          stack << ::Concerns::Arithmetic::Number.new(@cells[6].value_view)
        when /\A\$H/
          stack << ::Concerns::Arithmetic::Number.new(@cells[7].value_view)
        when /\A\$I/
          stack << ::Concerns::Arithmetic::Number.new(@cells[8].value_view)
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
