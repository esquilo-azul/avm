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
        end
      end
    end
  end
end
