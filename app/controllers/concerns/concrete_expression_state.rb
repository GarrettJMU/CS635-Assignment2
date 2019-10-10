module Concerns
  class ConcreteExpressionState < ViewState
    attr_reader :value

    def initialize
      @value = 'Expression'
    end

    def handle_value_view(index = nil, value = nil)
      @context.cells.each do |cell|
        cell.current_value = cell.value_view
      end
      @context.transition_to(::Concerns::ConcreteValueState.new)
    end

    def handle_equation_view(index = nil, parsed_value = nil, expression_value = nil)
      current_cell = @context.cells[index]
      current_cell.expression_view = expression_value
      current_cell.value_view = parsed_value
      current_cell.current_value = current_cell.expression_view || current_cell.value_view

    end
  end
end
