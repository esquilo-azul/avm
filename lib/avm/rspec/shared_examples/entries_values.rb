# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

::RSpec.shared_examples 'entries_values' do |spec_file, expected_values|
  describe '#read_entry' do
    config_path = spec_file.to_pathname
    config_path = config_path.dirname.join("#{config_path.basename_noext}_files", 'config.yml')
    ::EacRubyUtils::Rspec.default_setup.stub_eac_config_node(self, config_path)

    expected_values.each do |instance_id, values|
      values.each do |input, expected|
        context "when a auto value is requested for \"#{instance_id}.#{input}\"" do
          let(:instance) { described_class.by_id(instance_id) }

          it ".entry('#{input}').value should return \"#{expected}\"" do
            expect(instance.entry(input).value).to eq(expected)
          end
        end
      end
    end
  end
end
