# frozen_string_literal: true

require 'eac_ruby_base1'
EacRubyBase1::RootModuleSetup.perform __FILE__ do
  ignore 'rspec/shared_examples/*'
  require 'eac_docker'
  require 'eac_fs'
  require 'eac_cli'
  require 'eac_config'
  require 'rspec'
end
