# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module AutoValues
      class UriEntry
        common_constructor :entries_provider, :suffix

        def found?
          value.present?
        end

        def value
          ::Avm::Entries::UriBuilder.from_all_fields do |field_name|
            entries_provider.entry([suffix, field_name]).optional_value
          end.to_uri.to_s
        end
      end
    end
  end
end
