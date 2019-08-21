require './lib/journey.rb'

class Oystercard
  attr_reader :balance, :journey_list
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 2.5
  MINIMUM_FARE = 2.5
  PENALTY_FARE = 6

  def initialize(journey_class = Journey)
    @balance = 0
    @journey_list = {}
    @journey_number = 0
    @journey = journey_class
  end

  def exceed_limit?(number)
    @balance + number > BALANCE_LIMIT
  end

  def top_up(number)
    raise "Top up declined. Limit balance would be exceed £#{BALANCE_LIMIT}" if exceed_limit?(number)

    @balance += number
  end

  def fare
    deduct(MINIMUM_FARE)
  #   deduct(PENALTY_FARE) if not empty
  #   @journey.current_journey << 'INCOMPLETE JOURNEY'
  end

  def touch_in(station)
    raise 'You\'re balance is too low' if @balance < MINIMUM_BALANCE

    # @journey.add("INCOMPLETE JOURNEY") if @journey.in_journey?
    @journey = @journey.new
    @journey.add(station)
  end

  def touch_out(station)
    # penalty_fare if @journey.current_journey.empty?
    @journey.add(station)
    fare
    store
  end

  def store
    if @journey.length == 2
      key = "journey#{@journey_number + 1}".to_sym
      @journey_list[key] = @journey.current_journey
      @journey_number += 1
      @journey_list
    end
  end

  private
  def deduct(number)
    @balance -= number
  end
  
end
