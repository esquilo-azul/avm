# frozen_string_literal: true

require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Filesystem
          def auto_fs_path
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID,
                                  ::Avm::Instances::EntryKeys::FS_PATH) { |v| v + '/' + id }
          end

          def auto_data_fs_path
            inherited_entry_value(::Avm::Instances::EntryKeys::INSTALL_ID,
                                  ::Avm::Instances::EntryKeys::DATA_FS_PATH) { |v| v + '/' + id }
          end

          def auto_fs_url
            auto_fs_url_with_install || auto_fs_url_without_install
          end

          def auto_fs_url_with_install
            read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_URL)
              .if_present do |install_url|
              read_entry_optional('fs_path').if_present do |fs_path|
                "#{install_url}#{fs_path}"
              end
            end
          end

          def auto_fs_url_without_install
            return nil if read_entry_optional(::Avm::Instances::EntryKeys::INSTALL_URL).present?

            read_entry_optional('fs_path').if_present do |fs_path|
              "file://#{fs_path}"
            end
          end
        end
      end
    end
  end
end
