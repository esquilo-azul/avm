# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

::RSpec.shared_examples 'avm_file_format_file_resource_name' do |input_expected|
  describe '#file_resource_name' do
    input_expected.each do |path, expected_resource_name|
      context "when path is \"#{path}\"" do
        let(:instance) { described_class.new }

        it { expect(instance.file_resource_name(path)).to eq(expected_resource_name) }
      end
    end
  end
end
