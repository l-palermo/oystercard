require 'station'

RSpec.describe Station do
  subject { described_class.new("name", 2) }

  it 'return station name' do
    expect(subject.name).to eq("name")
  end

  it 'returns zone number' do
    expect(subject.zone).to eq(2)
  end

end