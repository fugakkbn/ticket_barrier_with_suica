class Suica
  attr_reader :balance, :entered_at

  def initialize(balance)
    @balance = balance
  end

  def discharge(amount)
    if @balance >= amount
      @balance -= amount
    else
      false
    end
  end

  def charge(amount)
    @balance += amount
  end

  def enter(name)
    @entered_at = name
  end
end
