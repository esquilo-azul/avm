# frozen_string_literal: true

RSpec.describe Avm::Instances::Base do
  it do
    expect(described_class.ancestors.map(&:name)).to(
      include('Avm::Instances::Base::Install')
    )
  end

  describe '#by_id' do
    {
      'avm-tools_0' => %w[avm-tools 0],
      'avm-tools_dev' => %w[avm-tools dev],
      'redmine1-abc2_dev3' => %w[redmine1-abc2 dev3]
    }.each do |id, expected|
      context "when input ID is \"#{id}\"" do
        let(:instance) { described_class.by_id(id) }

        it "returns application.id=#{expected.first}" do
          expect(instance.application.id).to eq(expected.first)
        end

        it "returns instance.suffix=#{expected.last}" do
          expect(instance.suffix).to eq(expected.last)
        end
      end
    end
  end
end
