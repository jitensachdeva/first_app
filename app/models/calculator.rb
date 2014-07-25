class Calculator < ActiveRecord::Base

  # def initialize state=0
  #   @state = state
  # end

  def + value
    self.state += value
    self.save
  end

  def - value
    self.state -= value
    self.save
  end

  def * value
    self.state *= value
    self.save
  end

  def / value
      if(value != 0)
        self.state /= value
        self.state.round(2)
        self.save
      else
        return "can not divide by zero"
      end



  end
end
