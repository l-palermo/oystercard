class Oystercard
  attr_reader :balance, :BALANCE_LIMIT
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 2.5
  MINIMUM_FAIR = 2.5

  def initialize
    @balance = 0
    @in_journey = false
  end

  def exceed_limit?(number)
    @balance + number > BALANCE_LIMIT
  end

  def top_up(number)
    raise "Top up declined. Limit balance would be exceed £#{BALANCE_LIMIT}" if exceed_limit?(number)

    @balance += number
  end

  def touch_in
    raise 'You\'re balance is too low' if @balance < MINIMUM_BALANCE

    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FAIR)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private
  def deduct(number)
    @balance -= number
  end
  
end
