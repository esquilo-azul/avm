# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_config/entry_path'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentEntryValue
        class DefaultValue
          enable_method_class
          common_constructor :uri_component_entry_value

          def result
            uri_component_entry_value.options[OPTION_DEFAULT_VALUE].call_if_proc
          end
        end
      end
    end
  end
end
