# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Base
      class UriComponentsEntriesValues
        class GenericComponent
          common_constructor :owner, :component
          delegate :entries_provider_class, :prefix, to: :owner

          def auto_method_name
            ['auto', component_method_name].join('_')
          end

          def component_method_name
            [prefix, component].join('_')
          end

          def define_auto_method(&block)
            entries_provider_class.define_method(auto_method_name, &block)
          end

          def define_inherited_value_proc_method(&block)
            entries_provider_class.define_method(inherited_value_proc_name, &block)
          end

          def entry_key_path
            ::EacConfig::EntryPath.assert([prefix, component])
          end

          def id_component
            @id_component ||= owner.component_factory('id')
          end

          def inherited_value_proc_name
            [component_method_name, 'inherited_value_proc'].join('_')
          end

          def setup
            outer_self = self
            define_auto_method do
              uri_component_entry_value(outer_self.entry_key_path.to_string)
            end
          end
        end
      end
    end
  end
end
