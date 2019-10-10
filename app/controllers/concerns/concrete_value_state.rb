module Concerns
  class ConcreteValueState < ViewState
    attr_reader :value

    def initialize
      @value = 'Value'
    end

    def handle_value_view(index = nil, value = nil)
      if index.blank?
        @context.cells.each do |cell|
          cell.current_view = cell.value_view
        end
      else
        @context.cells[index].value_view = value
      end

    end

    def handle_equation_view(index = nil, value = nil)
      @context.transition_to(::Concerns::ConcreteExpressionState.new)
    end
  end
end

