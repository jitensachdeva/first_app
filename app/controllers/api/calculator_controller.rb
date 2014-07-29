class Api::CalculatorController < ActionController::Base

  def create
    return head :ok if (Calculator.count == 1)
    calculator = Calculator.first_or_create!
    head :created
  end

  def update
    calculator = Calculator.first
    return head :not_found if calculator.nil?

    command = params[:command]
    puts params
    return head :bad_request if command.nil?

    parser = Parser.new(calculator)
    if parser.perform_operation(command)
      result = {:result => calculator.state}
      render json: result.to_json
    else
      head 422
    end
  end

  def index
  end


end