#parse and route input string
class Parser
  def initialize calculator
    @calculator = calculator
  end


  def perform_operation input_string
    operator, operand = parse input_string
    case operator
      when "add"
        @calculator + operand
      when "sub"
        @calculator - operand
      when "mul"
        @calculator * operand
      when "div"
        @calculator / operand
      when "reset"
        @calculator.reset
      else
        return false
    end
  end

  private
  def parse input_string
    operator, operand = input_string.split
    [operator, operand.to_f]
  end

end