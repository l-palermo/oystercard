class Oystercard
  attr_reader :balance, :journey_list, :current_journey
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 2.5
  MINIMUM_FAIR = 2.5

  def initialize
    @balance = 0
    @journey_list = {}
    @current_journey = []
    @journey_number = 0
  end

  def exceed_limit?(number)
    @balance + number > BALANCE_LIMIT
  end

  def top_up(number)
    raise "Top up declined. Limit balance would be exceed £#{BALANCE_LIMIT}" if exceed_limit?(number)

    @balance += number
  end

  def touch_in(station)
    raise 'You\'re balance is too low' if @balance < MINIMUM_BALANCE

    store(station)
    station
  end

  def touch_out(station)
    deduct(MINIMUM_FAIR)
    store(station)
    station
  end

  def in_journey?
    !@current_journey.empty? ? true : false
  end

  def store(station)
    @current_journey << station
    if @current_journey.length == 2
      key = "journey#{@journey_number + 1}".to_sym
      @journey_list[key] = @current_journey
      @journey_number += 1
      @current_journey = []
    end
  end

  private
  def deduct(number)
    @balance -= number
  end
  
end
