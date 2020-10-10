class EmptyStackError < StandardError; end
class InvalidTokenError < StandardError; end

class Minilang
  attr_accessor :stack, :register, :program

  OPERATIONS = %w(PRINT PUSH POP MULT ADD SUB DIV MOD)

  def initialize(program)
    @program = program.split(' ')
    @stack = []
    @register = 0
  end

  def eval
    program.each do |operation|
      if integer?(operation)
        @register = operation.to_i
      else
        raise InvalidTokenError, "Invalid token: #{operation}" unless OPERATIONS.include?(operation)
        self.send(operation.downcase.to_sym)
      end
    rescue StandardError => e 
      p e.message
    end
  end

  def integer?(value)
    value.to_i.to_s == value
  end

  def print
    p register
  end

  def pop 
    raise EmptyStackError, "Empty stack!" if stack.empty?
    stack.pop
  end

  def push 
    stack << register
  end

  def add 
    @register += pop
  end

  def sub 
    @register -= pop
  end

  def mult 
    @register *= pop
  end

  def div 
    @register /= pop
  end

  def mod 
    @register %= pop
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)