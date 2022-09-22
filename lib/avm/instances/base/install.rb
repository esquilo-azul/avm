# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module Install
        common_concern do
          uri_components_entries_values 'install', %w[data_path email groupname]
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
