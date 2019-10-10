module Concerns
  class ConcreteExpressionState < ViewState
    attr_reader :value

    def initialize
      @value = 'Expression'
    end

    def handle_value_view(cell = nil, value = nil)
      @context.cells.each do |c|
        c.current_value = c.value_view
      end
      @context.transition_to(::Concerns::ConcreteValueState.new)
    end

    def handle_equation_view(cell = nil, parsed_value = nil, expression_value = nil)
      cell.expression_view = expression_value
      cell.value_view = parsed_value
      cell.current_value = cell.expression_view || cell.value_view
      cell.notify_observers if cell.observers.length > 0
    end
  end
end
