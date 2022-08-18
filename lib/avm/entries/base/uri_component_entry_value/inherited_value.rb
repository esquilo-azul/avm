# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_config/entry_path'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentEntryValue
        class InheritedValue
          enable_method_class
          common_constructor :uri_component_entry_value
          delegate :entries_provider, :id_entry_path, :component_entry_path,
                   :options, to: :uri_component_entry_value

          def result
            entries_provider.inherited_entry_value(
              id_entry_path.to_string,
              component_entry_path.to_string,
              &inherited_value_block
            )
          end

          def inherited_value_block
            options[OPTION_INHERITED_VALUE_BLOCK]
          end
        end
      end
    end
  end
end
