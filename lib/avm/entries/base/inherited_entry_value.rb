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
          self_entry_value.if_present do |instance_id|
            other_entry_value(instance_id).if_present(&block)
          end
        end

        # @param provider_id [String]
        # @return [Avm::Entries::Base]
        def other_entries_provider(provider_id)
          ::Avm::Instances::Base.by_id(provider_id)
        end

        def other_entry_value(instance_id)
          other_entries_provider(instance_id).read_entry_optional(target_entry_suffix)
        end

        def self_entry_value
          entries_provider.read_entry_optional(source_entry_suffix)
        end
      end
    end
  end
end
