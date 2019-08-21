require 'oystercard'

RSpec.describe Oystercard do
  let(:station) { double :station }
  let(:journey_class) { double :journey_class }
  let(:journey) { double :journey }
  subject { described_class.new(journey_class)}


  it 'checks that the card object is initialized with no journeys' do 
    expect(subject.journey_list).to be_empty 
  end

  describe '#balance' do
      # expect(subject.balance).to be_instance_of(Integer)

    it 'has zero when intialized' do
      expect(subject.balance).to eq(0)
    end
  end



  describe '#top_up' do

    it 'raise an error if top_up makes balance greater than LIMIT' do
      limit = Oystercard::BALANCE_LIMIT
      expect { subject.top_up(91) }.to raise_error "Top up declined. Limit balance would be exceed £#{limit}"
    end

    it 'takes an argument and increment the balance' do
      expect(subject.top_up(3)).to eq(3)
    end

    # describe 'if #top up #exceed_limit?' do

    #   it 'returns true if balance exceeded' do
    #     expect(subject.exceed_limit?(91)).to eq true
    #   end
    # end
  end

  # describe '#deduct' do

  #   it 'takes an argument and deducts it from the balance' do
  #     oystercard = Oystercard.new
  #     oystercard.top_up(20)
  #     expect(oystercard.deduct(5)).to eq(15)
  #   end 
  # end
  
  describe '#touch_in' do
    before(:each) {
      allow(journey_class).to receive(:new) { journey }
      allow(journey).to receive(:add) { [station] }
      # allow(journey).to receive(:in_journey?) { true }
      # allow(journey).to receive(:current_journey) { [station, "INCOMPLETE JOURNEY"]}
    }

    it 'it returns an array with the entry station' do
      subject.top_up(2.5)
      expect(subject.touch_in(station)).to eq([station])
    end

    it 'raise an error if balance lower than minimum' do
      expect { subject.touch_in(station) }.to raise_error 'You\'re balance is too low'
    end
  end

  describe '#touch_out' do
    before(:each) { 
    allow(journey_class).to receive(:new) { journey }
    allow(journey).to receive(:add) { [station] }
    # allow(journey).to receive(:in_journey?) { true }
    # allow(journey).to receive(:current_journey) { [station, "INCOMPLETE JOURNEY"]}
    allow(journey).to receive(:length) { 2 }
    allow(journey).to receive(:current_journey) { [station, station] }
    subject.top_up(2.5)
    subject.touch_in(station) 
    }

    it 'returns station name' do
      expect(subject.touch_out(station)).to eq({:journey1 => [station, station]})
    end

    it 'deduct minimum fair' do
      minimum = Oystercard::MINIMUM_FARE
      expect { subject.touch_out(station) }.to change { subject.balance }.by -2.5
    end
  end

  # describe '#in_jounery?' do

  #   it 'return true if in journey' do
  #     subject.top_up(2.5)
  #     subject.touch_in(station)
  #     expect(subject).to be_in_journey
  #   end

  #   it 'return false if not in journey' do
  #     subject.top_up(2.5)
  #     subject.touch_in(station)
  #     subject.touch_out(station)
  #     expect(subject).to_not be_in_journey
  #   end
  # end

  describe '#store' do
    before(:each) { 
    allow(journey_class).to receive(:new) { journey }
    allow(journey).to receive(:add) { [station] }
    allow(journey).to receive(:length) { 2 }
    allow(journey).to receive(:current_journey) { [station, station] }
    subject.top_up(2.5)
    subject.touch_in(station)
    subject.touch_out(station) 
    }

    it 'return @journey_list' do
      expect(subject.journey_list).to eq({:journey1 => [station, station]})
    end
  end

  describe '#fare' do
    before(:each) { 
      allow(journey_class).to receive(:new) { journey }
      allow(journey).to receive(:add) { [station] }
      allow(journey).to receive(:length) { 2 }
      allow(journey).to receive(:current_journey) { [station, station] } 
      }

    it 'deduct MINIMUM_FARE when touch out' do
      subject.top_up(2.5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect { subject.fare }.to change { subject.balance }.by -2.5
    end

    # it 'deduct PENALTY_FARE if in_journey' do
      # expect { subject.fare }.to change { subject.balance }.by -6

      
    # it 'returns an array containing an incomplete journey' do
    #   expect(oystercard.penalty_fare).to include('INCOMPLETE JOURNEY')
    # end

  #   it 'deduct the penalty fair' do
  #     expect { subject.penalty_fare }.to change { subject.balance }.by -6
  #   end
  end

end
