# frozen_string_literal: true

class Gate
  STATIONS = %i[umeda juso mikuni]
  FARES = [160, 190]

  def initialize(name)
    @name = name
  end

  def enter_by_ticket(ticket)
    ticket.enter(@name)
  end

  def enter_by_suica(suica)
    suica.enter(@name)
  end

  def exit_by_suica(suica)
    fare = calc_fare(suica.entered_at)
    suica.discharge(fare)
    suica.balance
  end

  def exit_by_ticket(ticket)
    fare = calc_fare(ticket.entered_at)
    fare <= ticket.fare
  end

  def calc_fare(entered_at)
    from = STATIONS.index(entered_at)
    to = STATIONS.index(@name)
    distance = to - from
    FARES[distance - 1]
  end
end
