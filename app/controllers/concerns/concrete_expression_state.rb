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

      @context.cells[index].expression_view = expression_value
      @context.cells[index].value_view = parsed_value
    end
  end
end
