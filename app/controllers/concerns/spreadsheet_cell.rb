module Concerns
  class SpreadsheetCell

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

    end

    def notify_observers
      @observers.each do |observer|
        observer.update(self)
      end
    end
  end
end
