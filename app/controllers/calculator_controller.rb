class CalculatorController < ApplicationController

  before_action :authenticate_user!

  def update
    calculator = Calculator.first_or_create!
    parser = Parser.new(calculator)
    parser.perform_operation(params[:command]) unless params[:command].nil?
    @state = calculator.state
  end

  def index
    user = current_user
    puts user.calculator
  end

end
