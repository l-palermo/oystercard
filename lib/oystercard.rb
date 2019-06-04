class Oystercard
  attr_reader :balance, :BALANCE_LIMIT
  BALANCE_LIMIT = 90

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

  def deduct(number)
    @balance -= number
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end
  
end
