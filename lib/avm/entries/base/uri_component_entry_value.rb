# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_config/entry_path'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentEntryValue
        enable_method_class
        require_sub __FILE__, require_dependency: true

        enable_listable
        lists.add_symbol :option, :default_value, :inherited_value_block

        common_constructor :entries_provider, :component_entry_path, :options, default: [{}] do
          self.component_entry_path = ::EacConfig::EntryPath.assert(component_entry_path)
          self.options = self.class.lists.option.hash_keys_validate!(options)
        end

        def inherited_result
          entries_provider.inherited_entry_value(
            id_entry_path.to_string,
            component_entry_path.to_string,
            &inherited_value_block
          )
        end

        def inherited_value_block
          options[OPTION_INHERITED_VALUE_BLOCK]
        end

        # @return [EacConfig::EntryPath]
        def id_entry_path
          root_entry_path + %w[id]
        end

        # @return [String, nil]
        def result
          url_entry_value || inherited_result || default_value
        end

        # @return [EacConfig::EntryPath]
        def root_entry_path
          component_entry_path[0..-2]
        end

        # @return [Avm::Entries::Entry]
        def url_entry
          entries_provider.entry((root_entry_path + %w[url]).to_string)
        end

        def url_entry_value
          return unless url_entry.context_found?

          ::Avm::Entries::UriBuilder.from_source(url_entry.value.to_uri)
            .avm_field_get(component)
        end

        # @return [String]
        def component
          component_entry_path.last
        end
      end
    end
  end
end
