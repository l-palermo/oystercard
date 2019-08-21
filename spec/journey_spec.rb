require 'journey'

RSpec.describe Journey do
  let(:journey) { Journey.new }
  let(:station) { double :station }


  describe '#add' do 

    it 'returns and array with station' do
      expect(journey.add(station)).to eq([station])
    end
  end

  describe '#current_journey' do

    it 'returns an empty array when initialized' do
      expect(journey.current_journey).to eq []
    end

    it 'returns an array with station when #add is called' do
      journey.add(station)
      expect(journey.current_journey).to eq [station]
    end
  end

  describe '#in_jounery?' do

    it 'return true if in journey' do
      journey.add(station)
      expect(journey).to be_in_journey
    end

    it 'return false if not in journey' do
      expect(journey).to_not be_in_journey
    end
  end

  describe '#length' do

    it 'return the array length' do
      journey.add(station)
      expect(journey.length).to eq 1
    end
  end

  describe '#clear' do
    it 'return an empty array' do
    journey.add(station)
    expect(subject.clear).to eq []
    end
  end
end