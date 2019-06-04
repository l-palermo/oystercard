class Oystercard
  attr_reader :balance, :BALANCE_LIMIT, :entry_station
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 2.5
  MINIMUM_FAIR = 2.5

  def initialize
    @balance = 0
    @entry_station
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

    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FAIR)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil ? true : false
  end

  private
  def deduct(number)
    @balance -= number
  end
  
end
