require "observer"

module Concerns
  class SpreadsheetCell
    include Observable
    attr_accessor :observers, :value_view, :expression_view, :current_value, :state

    def initialize
      @current_value = nil
      @observers = []
      @expression_view = nil
      @value_view = nil
    end

    def handle_equation_view
      super(self, self.expression_view)
    end

    def update(context)
      context.handle_equation_view(self, self.expression_view)
    end

  end
end
