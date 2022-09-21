# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentsEntriesValues
        require_sub __FILE__
        common_constructor :entries_provider_class, :prefix, :extra_fields

        ENTRIES_FIELDS = ::Avm::Entries::UriBuilder::ENTRIES_FIELDS

        def fields
          ENTRIES_FIELDS + extra_fields
        end

        def result
          fields.map { |field| component_factory(field).setup }
        end
      end
    end
  end
end
