class Suica
  attr_reader :balance, :entered_at

  def initialize(balance)
    @balance = balance
  end

  def discharge(fare)
    @balance -= fare
  end

  def enter(name)
    @entered_at = name
  end
end
