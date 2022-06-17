# frozen_string_literal: true

class Ticket
  attr_reader :fare, :entered_at

  def initialize(fare)
    @fare = fare
  end

  def enter(name)
    @entered_at = name
  end
end
