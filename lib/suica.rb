class Suica
  attr_reader :balance, :entered_at

  def initialize(balance)
    @balance = balance
  end

  # TODO: マイナスの金額が渡ってきた場合を考慮する
  def discharge(amount)
    if @balance >= amount
      @balance -= amount
    else
      false
    end
  end

  # TODO: マイナスの金額が渡ってきた場合を考慮する
  def charge(amount)
    @balance += amount
  end

  def enter(name)
    @entered_at = name
  end
end
