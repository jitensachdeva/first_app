class CalculatorController < ApplicationController
  def update
    calculator = Calculator.first_or_create!
    p calculator
    parser = Parser.new(calculator)
    parser.perform_operation(params["command"])
    render :text => calculator.state, :status => :ok
  end
end
