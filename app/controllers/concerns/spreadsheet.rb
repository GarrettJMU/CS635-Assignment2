module Concerns
  class Spreadsheet

    attr_accessor :current_view, :cells, :state

    def initialize(state)
      @cells = []
      @current_view = 'Value'
      @context_parser = ::Concerns::ContextParser.new

      1..9.times { @cells.push(SpreadsheetCell.new) }
      transition_to(state)
    end

    def transition_to(state)
      @state = state
      @state.context = self
      @current_view = @state.value

      @cells.each do |cell|
        cell.state = state
      end
    end

    def handle_value_view(cell = nil, value = nil)
      @state.handle_value_view(cell, value)
    end

    def handle_equation_view(cell = nil, value = nil, parsed = nil)
      parsed_value = parse(value, cell)
      @state.handle_equation_view(cell, parsed_value, value)
    end

    def parse(context, cell)
      @context_parser.parse(context, cell, self)
    end

  end
end
