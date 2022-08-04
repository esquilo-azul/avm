# frozen_string_literal: true

require 'avm/entries/auto_values/entry'
require 'eac_config/node'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    class Entry
      common_constructor :parent, :suffix, :options

      def auto_value
        ::Avm::Entries::AutoValues::Entry.new(parent, suffix).value
      end

      def full_path
        (parent.path_prefix + suffix_as_array).join('.')
      end

      def optional_value
        context_entry.found? ? context_entry.value : auto_value
      end

      def read
        context_entry.value
      end

      def suffix_as_array
        if suffix.is_a?(::Array)
          suffix.dup
        else
          ::EacConfig::PathsHash.parse_entry_key(suffix.to_s)
        end
      end

      def value
        optional_value || read
      end

      def write(value)
        context_entry.value = value
      end

      private

      def context_entry
        ::EacConfig::Node.context.current.entry(full_path)
      end
    end
  end
end
