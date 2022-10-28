# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Rspec
    module Setup
      module SourceGenerator
        # @return [Avm::Sources::Base]
        def avm_source(stereotype_name, options = {})
          target_path ||= options.delete(:target_path) || temp_dir.join('generated_app')
          ::Avm::Registry.source_generators.detect(stereotype_name, target_path, options).perform
          ::Avm::Registry.sources.detect(target_path)
        end
      end
    end
  end
end
