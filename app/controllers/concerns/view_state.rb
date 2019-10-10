module Concerns
  class ViewState
    attr_accessor :context

    def handle_value_view
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def handle_equation_view
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end

end
