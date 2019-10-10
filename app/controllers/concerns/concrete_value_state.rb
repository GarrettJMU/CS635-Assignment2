module Concerns
  class ConcreteValueState < ViewState
    attr_reader :value

    def initialize
      @value = 'Value'
    end

    def handle_value_view(index = nil, value = nil)
      @context.cells[index].value_view = value
    end

    def handle_equation_view(index = nil, value = nil, parsed_value = nil)
      @context.cells.each do |cell|
        cell.current_value = cell.expression_view || cell.value_view
      end
      @context.transition_to(::Concerns::ConcreteExpressionState.new)
    end
  end
end

