# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Install
          def auto_install_data_path
            uri_component_entry_value(
              ::Avm::Instances::EntryKeys::INSTALL_DATA_PATH,
              inherited_value_block: ->(v) { v + '/' + id }
            )
          end

          (::Avm::Entries::UriBuilder::ENTRIES_FIELDS + %w[groupname]).each do |component|
            method_suffix = "install_#{component}"
            define_method "auto_#{method_suffix}" do
              uri_component_entry_value(
                ::Avm::Instances::EntryKeys.const_get(method_suffix.underscore.upcase)
              )
            end
          end

          def auto_install_url
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID,
                                  ::Avm::Instances::EntryKeys::INSTALL_URL) ||
              auto_install_url_by_parts
          end

          def auto_install_url_by_parts
            require 'avm/entries/auto_values/uri_entry'
            ::Avm::Entries::AutoValues::UriEntry.new(self, 'install').value
          end

          def groupname_default_value
            read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_USERNAME)
          end
        end
      end
    end
  end
end
