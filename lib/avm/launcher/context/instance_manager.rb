# frozen_string_literal: true

require('yaml')

module Avm
  module Launcher
    class Context
      class InstanceManager
        enable_memoized
        common_constructor :context

        memoize def cached_instances_file_content
          cached_instances_file_content_unmemoized
        end

        memoize def instances
          (cached_instances || search_instances).select(&:included?)
        end

        # @param instance [Avm::Launcher::Paths::Logical]
        # @param stereotype_name [String]
        # @param check_status [String]
        def publish_state_set(instance, stereotype_name, check_status)
          cached_instances_obj.by_logical_path(instance.logical)
            .publish_state_set(stereotype_name, check_status)
        end

        def pending_instances
          instances.select { |instance| pending_instance?(instance) }
        end

        protected

        # @return [Avm::Launcher::Context::InstanceManager::CachedInstances]
        memoize def cached_instances_obj
          Avm::Launcher::Context::InstanceManager::CachedInstances.new(self)
        end

        private

        def search_instances
          cached_instances_obj.write_instances(
            ::Avm::Launcher::Context::InstanceDiscovery.new(context).instances
          )
        end

        def cached_instances
          return nil if context.recache
          return nil unless cached_instances_obj.content

          cached_instances_obj.instances
        end

        # @param instance [Avm::Launcher::Paths::Logical]
        # @return [Boolean]
        def pending_instance?(instance)
          data = cached_instances_obj.by_logical_path(instance.logical).data
          return false unless data
          return false unless data[:publish_state].is_a?(Hash)

          data[:publish_state].any? do |_k, v|
            ::Avm::Launcher::Publish::CheckResult.pending_status?(v)
          end
        end
      end
    end
  end
end
