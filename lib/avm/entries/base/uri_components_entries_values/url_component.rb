# frozen_string_literal: true

require 'avm/entries/base/uri_components_entries_values/generic_component'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentsEntriesValues
        class UrlComponent < ::Avm::Entries::Base::UriComponentsEntriesValues::GenericComponent
          def setup
            outer_self = self
            define_auto_method do
              inherited_entry_value(outer_self.id_component.entry_key_path.to_string,
                                    outer_self.entry_key_path.to_string) ||
                outer_self.auto_install_url_by_parts(self)
            end
          end

          def auto_install_url_by_parts(entries_provider)
            require 'avm/entries/auto_values/uri_entry'
            ::Avm::Entries::AutoValues::UriEntry.new(entries_provider, 'install').value
          end
        end
      end
    end
  end
end
