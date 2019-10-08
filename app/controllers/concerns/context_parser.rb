module Concerns
  class ContextParser

    attr_accessor :context

    def initialize(context)
      @context = context
    end

    def parse
      stack = []

      @context.strip
      while @context.length > 0

        case @context.split(' ').first
        when /\A-?\d+(\.\d+)?/
          stack << ::Concerns::Arithmetic::Number.new(@context.split(' ').first.to_i)
        else
          second, first = stack.pop(), stack.pop()

          case @context.split(' ').first
          when /\A\+/
            puts 'hitting here'
            stack << ::Concerns::Arithmetic::Add.new(first, second)
          when /\A\-/
            stack << ::Concerns::Arithmetic::Subtract.new(first, second)
          when /\A\*/
            stack << ::Concerns::Arithmetic::Multiply.new(first, second)
          else
            raise 'Token unknown'
          end
        end

        @context = context.split(' ')[1..-1].join(' ')

        @context.strip
      end

      raise 'Syntax error' unless stack.size == 1
      puts 'stack in executable'
      puts stack.inspect
      puts 'stack in executable'
      stack.first.execute
    end

  end
end
