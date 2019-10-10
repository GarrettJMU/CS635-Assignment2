module Context
  class Memento
    attr_accessor :state

    def initialize(state)
      @state = state
    end
  end
end
