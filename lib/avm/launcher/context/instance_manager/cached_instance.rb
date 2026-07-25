# frozen_string_literal: true

module Avm
  module Launcher
    class Context
      class InstanceManager
        class CachedInstance
          enable_memoized
          enable_speaker
          common_constructor :cached_instances, :logical_path

          # @return [Hash]
          memoize def data
            content.fetch(logical_path)
          end

          # @return [Hash, nil]
          memoize def instance
            ::Avm::Launcher::Instances::Base.instanciate(path, parent_instance)
          rescue ::Avm::Launcher::Errors::NonProject
            warn "Cached instance \"#{data[:logical]}\" not found"
            nil
          end

          # @return [Hash, nil]
          memoize def parent_instance
            data[:parent]
              .if_present { |v| cached_instances.by_logical_path(v) }
              .if_present(&:instance)
          end

          # @return [Avm::Launcher::Paths::Logical]
          memoize def path
            ::Avm::Launcher::Paths::Logical.from_h(cached_instances.instance_manager, data)
          end
        end
      end
    end
  end
end
