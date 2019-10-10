module Concerns
  class SpreadsheetCell < Spreadsheet
    attr_accessor :observers, :value_view, :expression_view, :current_value

    def initialize
      @current_value = nil
      @observers = []
      @expression_view = nil
      @value_view = nil
    end

    def add_observer(observer)
      @observers << observer
    end

    def delete_observers
      @observers = []
    end


    def handle_equation_view
      super(self, self.expression_view)
    end

    def update
      method(:handle_equation_view).super_method.call
    end

    def notify_observers
      @observers.each do |observer|
        observer.update
      end
    end
  end
end
