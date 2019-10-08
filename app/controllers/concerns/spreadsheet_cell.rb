module Concerns
  class SpreadsheetCell

    attr_accessor :values, :observers, :current_index
    attr_reader :current_value

    def initalize
      @current_value = values[current_index]
      @values = []
      @current_index = 0
      @observers = []
    end

    def undo
      current_index === 0 ? 0 : (current_index -= 1)
    end

    def redo
      current_index === 0 ? nil : (current_index += 1)
    end

    def add_observer(observer)
      observers << observer
    end

    def delete_observer(observer)
      observer.delete(observer)
    end

    def notify_observers
      observers.each do |observer|
        observer.update(self)
      end
    end

    def update(cell)

    end

  end
end
