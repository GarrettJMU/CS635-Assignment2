module Concerns
  class ConcreteExpressionState < ViewState
    attr_reader :value

    def initialize
      @value = 'Expression'
    end

    def handle_value_view(index = nil, value = nil)
      @context.transition_to(::Concerns::ConcreteValueState.new)
    end

    def handle_equation_view(index = nil, value = nil)
      if index.blank?
        @context.cells.each do |cell|
          puts '#################'
          puts cell.inspect
          puts '#################'
          cell.current_view = cell.expression_view || cell.value_view
        end
      else
        @context.cells[index].expression_view = value
      end

    end
  end
end
