module Concerns
  class SpreadsheetCell

    attr_accessor :values, :observers, :current_index, :value_view, :expression_view, :current_value, :state

    def initialize
      @current_value = nil
      @observers = []
      @expression_view = nil
      @value_view = nil
    end

    # def transition_to(state)
    #   @state = state
    #   @state.context = self
    #   @current_view = @state.value
    #
    #   if @current_view === 'Expression'
    #     @cells.each do |cell|
    #       cell.update_view
    #     end
    #   else
    #     @cells.each do |cell|
    #       # cell.update_view
    #     end
    #   end
    # end


    def update_value(value)
      @current_value = value
    end

    # def create_memento
    #   @memento = ::Concerns::Memento.new(@state)
    # end
    #
    # def restore_memento(memento)
    #   @memento = memento
    #   @state  = memento.state
    # end

    def add_observer(observer)
      @observers << observer
    end

    def delete_observer(observer)
      @observers.delete(observer)
    end

    def notify_observers
      @observers.each do |observer|
        observer.update(self)
      end
    end
  end
end
