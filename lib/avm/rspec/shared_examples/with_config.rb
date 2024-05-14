# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

RSpec.shared_examples 'with_config' do |spec_file|
  config_path = spec_file.to_pathname
  config_path = config_path.dirname.join("#{config_path.basename_noext}_files", 'config.yml')
  EacRubyUtils::Rspec.default_setup.stub_eac_config_node(self, config_path)
end
