module Context
  class Caretaker
    def initialize
      @mementos = Array.new
    end

    def add_memento(memento)
      @mementos << memento
    end

    def get_memento
      @mementos.pop()
      @mementos.last
    end
  end
end
