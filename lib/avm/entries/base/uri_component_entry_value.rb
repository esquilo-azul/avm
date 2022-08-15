# frozen_string_literal: true

require 'eac_config/entry_path'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentEntryValue
        enable_method_class
        common_constructor :entries_provider, :component_entry_path do
          self.component_entry_path = ::EacConfig::EntryPath.assert(component_entry_path)
        end

        def inherited_result
          entries_provider.inherited_entry_value(
            id_entry_path.to_string,
            component_entry_path.to_string
          )
        end

        # @return [EacConfig::EntryPath]
        def id_entry_path
          root_entry_path + %w[id]
        end

        # @return [String, nil]
        def result
          inherited_result
        end

        # @return [EacConfig::EntryPath]
        def root_entry_path
          component_entry_path[0..-2]
        end
      end
    end
  end
end
