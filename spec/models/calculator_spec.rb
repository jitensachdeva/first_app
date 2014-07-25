require 'rails_helper'

describe Calculator do

  context 'Operations' do

    let(:calculator) { Calculator.new({:state => 3}) }
    context '#add' do

      it "should perform addition" do
        calculator + 5
        expect(calculator.state).to eq(8)
      end

      it "should save the state" do
        calculator + 5
        expect(calculator.reload.state).to eq(8)
      end

    end

    context '#subtract' do

      it "should perform subtraction" do
        calculator - 5
        expect(calculator.state).to eq(-2)
      end

      it "should save the state" do
        calculator - 5
        expect(calculator.reload.state).to eq(-2)
      end

    end

    context '#multiply' do

      it "should perform multiplication" do
        calculator * 5
        expect(calculator.state).to eq(15)
      end

      it "should save the state" do
        calculator * 5
        expect(calculator.reload.state).to eq(15)
      end

    end

    context '#divide' do

      it "should perform division" do
        calculator / 5
        expect(calculator.state).to eq(0.6)
      end

      it "should save the state" do
        calculator / 5
        expect(calculator.reload.state).to eq(0.6)
      end

      it 'should not raise exception for divide by zero' do
        expect(calculator / 0).to eq("can not divide by zero")
      end

    end

    context "#reset" do
      it "should perform division" do
        #calculator * 5
        calculator.reset
        expect(calculator.state).to eq(0)
      end

      it "should save the state" do
       # calculator * 5
        calculator.reset
        expect(calculator.reload.state).to eq(0)
      end
    end

  end
end
