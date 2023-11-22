# frozen_string_literal: true

require 'avm/entries/base/uri_components_entries_values/generic_component'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentsEntriesValues
        class PathComponent < ::Avm::Entries::Base::UriComponentsEntriesValues::GenericComponent
          def setup
            super
            define_inherited_value_proc_method { |value| "#{value}/#{id}" }
          end
        end
      end
    end
  end
end
