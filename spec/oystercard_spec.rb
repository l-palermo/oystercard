require 'oystercard'

RSpec.describe Oystercard do
  let(:station) { double :station }

  describe '#balance' do

    it 'responds to #balance' do
      expect(subject.balance).to be_instance_of(Integer)
    end

    it 'has zero when intialized' do
      expect(subject.balance).to eq(0)
    end

  end

  describe 'if #top up #exceed_limit?' do

    it 'returns true if balance exceeded' do
      expect(subject.exceed_limit?(91)).to eq true
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
  end

  # describe '#deduct' do

  #   it 'takes an argument and deducts it from the balance' do
  #     oystercard = Oystercard.new
  #     oystercard.top_up(20)
  #     expect(oystercard.deduct(5)).to eq(15)
  #   end 
  # end
  
  describe '#touch_in' do

    it 'store the station name' do
      subject.top_up(2.5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it 'raise an aerror if balance lower than minimum' do
      expect { subject.touch_in(station) }.to raise_error 'You\'re balance is too low'
    end
  end

  describe '#touch_out' do

    it 'eq @entry_station to nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'deduct minimum fair' do
      minimum = Oystercard::MINIMUM_FAIR
      subject.top_up(2.5)
      expect { subject.touch_out }.to change { subject.balance }.by -2.5
    end

    it 'returns nil' do
      expect(subject.touch_out).to eq nil
    end
  end

  describe '#in_jounery?' do

    it 'return true if in journey' do
      subject.top_up(2.5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'return false if not in journey' do
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

  end

end
