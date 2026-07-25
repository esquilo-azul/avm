# frozen_string_literal: true

module Avm
  module Launcher
    class Context
      class InstanceManager
        class CachedInstances
          enable_memoized
          common_constructor :instance_manager
          delegate :content, to: :instance_manager

          memoize def cached_instances
            {}
          end

          def instances
            content.keys.map { |k| by_logical_path(k).instance }.compact_blank
          end

          def by_logical_path(key)
            cached_instances[key].if_blank do
              cached_instances[key] = ::Avm::Launcher::Context::InstanceManager::CachedInstance.new(
                self, content.fetch(key)
              )
            end
          end

          # @return [String]
          def root_file_path
            ::File.join(instance_manager.context.cache_root, 'instances.yml')
          end
        end
      end
    end
  end
end
