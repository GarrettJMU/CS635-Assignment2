module Concerns
  class ConcreteValueState < ViewState
    attr_reader :value

    def initialize
      @value = 'Value'
    end

    def handle_value_view(cell = nil, value = nil)
      cell.value_view = value
      cell.current_value = value
      cell.changed
      cell.notify_observers
    end

    def handle_equation_view(cell = nil, value = nil, parsed_value = nil)
      @context.cells.each do |c|
        c.current_value = c.expression_view || c.value_view
      end
      @context.transition_to(::Concerns::ConcreteExpressionState.new)
    end

  end
end
