# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_config/entry_path'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class InheritedEntryValue
        enable_method_class
        common_constructor :entries_provider, :source_entry_suffix, :target_entry_suffix, :block,
                           block_arg: true

        def result
          entries_provider.read_entry_optional(source_entry_suffix).if_present do |instance_id|
            other_entry_value(instance_id, target_entry_suffix).if_present(&block)
          end
        end

        def other_entry_value(instance_id, entry_suffix)
          ::Avm::Instances::Base.by_id(instance_id).read_entry_optional(entry_suffix)
        end
      end
    end
  end
end
