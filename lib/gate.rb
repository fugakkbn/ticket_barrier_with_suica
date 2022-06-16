# frozen_string_literal: true

class Gate
  STATIONS = %i[umeda juso mikuni]
  FARES = [160, 190]

  def initialize(name)
    @name = name
  end

  def enter(ticket)
    ticket.stamp(@name)
  end

  def enter_by_suica(suica)

  end

  def exit_by_suica(suica)
    suica.discharge(160)
    suica.balance
  end

  def exit(ticket)
    fare = calc_fare(ticket)
    fare <= ticket.fare
  end

  def calc_fare(ticket)
    from = STATIONS.index(ticket.stamped_at)
    to = STATIONS.index(@name)
    distance = to - from
    FARES[distance - 1]
  end
end
