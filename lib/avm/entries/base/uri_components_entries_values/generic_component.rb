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

          def define_auto_method
            outer_self = self
            entries_provider_class.define_method(auto_method_name) do
              uri_component_entry_value(outer_self.entry_key_path.to_string)
            end
          end

          def define_get_method
            outer_self = self
            entries_provider_class.define_method(get_method_name) do
              read_entry(outer_self.entry_key_path.to_string)
            end
          end

          def define_inherited_value_proc_method(&block)
            entries_provider_class.define_method(inherited_value_proc_name, &block)
          end

          def entry_key_path
            ::EacConfig::EntryPath.assert([prefix, component])
          end

          # @return [String]
          def get_method_name # rubocop:disable Naming/AccessorMethodName
            component_method_name
          end

          def id_component
            @id_component ||= owner.component_factory('id')
          end

          def inherited_value_proc_name
            [component_method_name, 'inherited_value_proc'].join('_')
          end

          def setup
            define_auto_method
            define_get_method
          end
        end
      end
    end
  end
end
