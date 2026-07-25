# frozen_string_literal: true

module Avm
  module Launcher
    class Context
      class InstanceManager
        class CachedInstances
          enable_memoized
          common_constructor :instance_manager, :content

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
        end
      end
    end
  end
end
