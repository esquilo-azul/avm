# frozen_string_literal: true

require 'avm/rspec/setup/source_generator'
require 'eac_ruby_utils/core_ext'

module Avm
  module Rspec
    module Setup
      require_sub __FILE__
      EXAMPLES = %w[avm_file_formats_with_fixtures avm_source_generated entries_values
                    in_avm_registry not_in_avm_registry].freeze

      def self.extended(obj)
        obj.setup_examples
        obj.rspec_config.include(::Avm::Rspec::Setup::Launcher)
        obj.rspec_config.include(::Avm::Rspec::Setup::SourceGenerator)
      end

      def setup_examples
        EXAMPLES.each do |example|
          require "avm/rspec/shared_examples/#{example}"
        end
      end

      # @return [self]
      def stub_avm_contexts
        stub_eac_config_node
        stub_eac_fs_contexts
        stub_eac_speaker

        self
      end
    end
  end
end
