class Suica
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def discharge(fare)
    @balance -= fare
  end
end
