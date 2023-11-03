# frozen_string_literal: true

require 'avm/registry'
require 'eac_config/node'
require 'eac_ruby_utils/core_ext'

module Avm
  module Applications
    class Base
      module LocalSource
        # @return [Pathname]
        def local_source_path
          (local_source_path_entry.value || auto_local_source_path).to_pathname
        end

        # @return [EacConfig::Entry]
        def local_source_path_entry
          ::EacConfig::Node.context.current.entry([local_instance_id, 'install', 'path'])
        end

        private

        # @return [Avm::Sources::Base]
        def local_source_uncached
          ::Avm::Registry.sources.detect(local_source_path)
        end
      end
    end
  end
end
