# frozen_string_literal: true

RSpec.describe Avm::Sources::Update::Selection do
  {
    [[], []] => { 'a' => true, 'b' => true, 'c' => true },
    [%w[a b], []] => { 'a' => true, 'b' => true, 'c' => false },
    [[], %w[a]] => { 'a' => false, 'b' => true, 'c' => true },
    [%w[a b], %w[b]] => { 'a' => true, 'b' => false, 'c' => false }
  }.each do |(includes, excludes), expected|
    context "when includes are #{includes} and excludes are #{excludes}" do
      let(:instance) { described_class.new.includes(includes).excludes(excludes) }

      expected.each do |change_id, result|
        it { expect(instance.selected?(change_id)).to eq(result) }
      end
    end
  end

  context 'when includes and excludes are added one by one' do
    let(:instance) { described_class.new.include(:a).include(:b).exclude(:b) }

    { 'a' => true, 'b' => false, 'c' => false }.each do |change_id, result|
      it { expect(instance.selected?(change_id)).to eq(result) }
    end
  end

  describe '#subs?' do
    it { expect(described_class.new.subs?).to be(true) }
    it { expect(described_class.new.subs(false).subs?).to be(false) }
  end
end
