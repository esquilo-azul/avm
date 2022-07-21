# frozen_string_literal: true

require 'avm/registry/application_stereotypes/stereotype_builder'
require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class ApplicationStereotypes
      class BuildAvailable
        enable_method_class

        common_constructor :owner

        def result
          reset_buffer
          read_instances_registry
          read_sources_registry
          buffer.values.map(&:build)
        end

        private

        attr_accessor :buffer

        def read_object(type, object)
          buffer[object.stereotype_namespace_module] ||=
            ::Avm::Registry::ApplicationStereotypes::StereotypeBuilder
              .new(object.stereotype_namespace_module)
          buffer[object.stereotype_namespace_module].add_object(type, object)
        end

        def read_instances_registry
          ::Avm::Registry.instances.available.each { |instance| read_object(:instance, instance) }
        end

        def read_sources_registry
          ::Avm::Registry.sources.available.each { |source| read_object(:source, source) }
        end

        def reset_buffer
          self.buffer = {}
        end
      end
    end
  end
end
