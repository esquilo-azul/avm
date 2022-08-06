# frozen_string_literal: true

require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Install
          def auto_install_hostname
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID,
                                  ::Avm::Instances::EntryKeys::INSTALL_HOSTNAME)
          end

          def auto_install_port
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID,
                                  ::Avm::Instances::EntryKeys::INSTALL_PORT) || 22
          end

          def auto_install_username
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID,
                                  ::Avm::Instances::EntryKeys::INSTALL_USERNAME)
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
        end
      end
    end
  end
end
