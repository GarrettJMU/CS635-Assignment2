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
      @observers.each do |observer|
        delete(observer)
      end
    end

    def update(observee)
      # puts '##################'
      # puts observee.inspect
      # puts '##################'
      # parsed_value = parse(self.expression_view, nil, observee)
      #
      # handle_equation_view(current_index, parsed_value, self.expression_view)
    end

    def notify_observers
      @observers.each do |observer|
        observer.update(self)
      end
    end
  end
end
