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

        def publish_state_set(instance, stereotype_name, check_status)
          data = cached_instances_file_content_unmemoized
          data[instance.logical] ||= {}
          data[instance.logical][:publish_state] ||= {}
          data[instance.logical][:publish_state][stereotype_name] = check_status
          write_cache_file(data)
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
          cache_instances(::Avm::Launcher::Context::InstanceDiscovery.new(context).instances)
        end

        def cached_instances
          return nil if context.recache
          return nil unless cached_instances_file_content

          cached_instances_obj.instances
        end

        def cached_instances_file_content_unmemoized
          r = YAML.load_file(cached_instances_obj.root_file_path)
          r.is_a?(::Hash) ? r : nil
        rescue Errno::ENOENT
          nil
        end

        def cache_instances(instances)
          write_cache_file(instances.to_h { |i| [i.logical, i.to_h] })
          instances
        end

        def write_cache_file(data)
          cached_instances_obj.root_file_path.to_pathname.parent.mkpath
          ::File.write(cached_instances_obj.root_file_path, data.to_yaml)
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
