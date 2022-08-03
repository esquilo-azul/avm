# frozen_string_literal: true

require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Install
          def auto_access
            read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_URL).present? ? 'ssh' : 'local'
          end

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
            read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_HOSTNAME).if_present do |a|
              a = read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_USERNAME)
                    .if_present(a) { |v| "#{v}@#{a}" }
              a = read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_PORT)
                    .if_present(a) { |v| "#{a}:#{v}" }
              "ssh://#{a}"
            end
          end
        end
      end
    end
  end
end
