# frozen_string_literal: true

module Avm
  module Entries
    module Base
      class UriComponentsEntriesValues
        class UrlComponent < ::Avm::Entries::Base::UriComponentsEntriesValues::GenericComponent
          def define_auto_method
            outer_self = self
            entries_provider_class.define_method(auto_method_name) do
              outer_self.auto_by_paths(self)
            end
          end

          def auto_by_paths(entries_provider)
            ::Avm::Entries::AutoValues::UriEntry.new(entries_provider, owner.prefix).value
          end
        end
      end
    end
  end
end
