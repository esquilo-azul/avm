# frozen_string_literal: true

require 'avm/rspec/source_generator'
require 'eac_ruby_utils/core_ext'

module Avm
  module Rspec
    module Setup
      require_sub __FILE__
      EXAMPLES = %w[avm_file_formats_with_fixtures entries_values in_avm_registry
                    not_in_avm_registry].freeze

      def self.extended(obj)
        obj.setup_examples
        obj.rspec_config.include(::Avm::Rspec::Setup::Launcher)
        obj.rspec_config.include(::Avm::Rspec::SourceGenerator)
      end

      def setup_examples
        EXAMPLES.each do |example|
          require "avm/rspec/shared_examples/#{example}"
        end
      end
    end
  end
end
