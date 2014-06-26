require 'rspec'
require_relative '../lib/boggle'

describe Boggle do
  let(:game) { Boggle.new(%w[E E C A
                             A L E P
                             H N B O
                             Q T T Y
                            ]
                         )
  }

  it 'loads a dictionary' do
    expect(game.dictionary).to include('toecap', 'hammer')
  end
  it 'finds horizontal words' do
    expect(game.solve.results).to include('ale')
  end
  it 'finds vertical words' do
    expect(game.solve.results).to include('ah')
  end
  it 'can switch directions once a partial match is made' do
    expect(game.solve.results).to include('cap')
  end
  it "continues to see if there are other matches even if a previous word is found" do
    expect(game.solve.results).to include('cape')
  end
  it "finds Russell's word" do
    expect(game.solve.results).to include('toecap')
  end

end
