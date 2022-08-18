# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Install
          (::Avm::Entries::UriBuilder::ENTRIES_FIELDS + %w[data_path groupname]).each do |component|
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

          def install_data_path_inherited_value_proc(value)
            value + '/' + id
          end

          def install_groupname_default_value
            read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_USERNAME)
          end

          def install_path_inherited_value_proc(value)
            install_data_path_inherited_value_proc(value)
          end
        end
      end
    end
  end
end
