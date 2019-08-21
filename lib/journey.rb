class Journey
  attr_reader :current_journey

  def initialize
    @current_journey = []
  end

  def add(station)
    @current_journey << station
  end

  def length
    @current_journey.length
  end

  def clear
    @current_journey.clear
  end

  def in_journey?
    !current_journey.empty?
  end
end