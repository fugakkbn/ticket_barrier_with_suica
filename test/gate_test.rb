# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/gate'
require_relative '../lib/ticket'
require_relative '../lib/suica'

class GateTest < Minitest::Test
  def setup
    @umeda = Gate.new(:umeda)
    @juso = Gate.new(:juso)
    @mikuni = Gate.new(:mikuni)
  end

  def test_umeda_to_juso
    ticket = Ticket.new(160)
    @umeda.enter_by_ticket(ticket)
    assert @juso.exit_by_ticket(ticket)
  end

  def test_umeda_to_mikuni_when_fare_is_not_enough
    ticket = Ticket.new(160)
    @umeda.enter_by_ticket(ticket)
    refute @mikuni.exit_by_ticket(ticket)
  end

  def test_umeda_to_mikuni_when_fare_is_enough
    ticket = Ticket.new(190)
    @umeda.enter_by_ticket(ticket)
    assert @mikuni.exit_by_ticket(ticket)
  end

  def test_juso_to_mikuni
    ticket = Ticket.new(160)
    @juso.enter_by_ticket(ticket)
    assert @mikuni.exit_by_ticket(ticket)
  end

  def test_umeda_to_juso_when_balance_is_1000
    suica = Suica.new(1000)
    @umeda.enter_by_suica(suica)
    assert_equal 1000, suica.balance
    assert_equal 840, @juso.exit_by_suica(suica)
    assert_equal 840, suica.balance
  end

  # 残高が100円ありチャージせず梅田駅で乗車し十三駅で降車 -> 出場できない
  def test_umeda_to_juso_when_balance_is_100
    suica = Suica.new(100)
    @umeda.enter_by_suica(suica)
    assert_equal 100, suica.balance
    refute @juso.exit_by_suica(suica)
    assert_equal 100, suica.balance
  end

  def test_umeda_to_juso_when_charge_is_160
    suica = Suica.new(0)
    suica.charge(160)
    assert_equal 160, suica.balance
    @umeda.enter_by_suica(suica)
    assert_equal 160, suica.balance
    assert_equal 0, @juso.exit_by_suica(suica)
    assert_equal 0, suica.balance
  end

  def test_umeda_to_juso_when_charge_is_159
    suica = Suica.new(0)
    suica.charge(159)
    assert_equal 159, suica.balance
    @umeda.enter_by_suica(suica)
    assert_equal 159, suica.balance
    refute @juso.exit_by_suica(suica)
    assert_equal 159, suica.balance
  end
end
