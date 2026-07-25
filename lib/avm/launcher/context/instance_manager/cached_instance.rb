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
            ::YAML.load_file(data_path)
          end

          # @param value [Hash]
          def data=(value)
            data_path.assert_parent.write(value.to_yaml)
            unmemoize_all
          end

          # @return [Pathname]
          def data_path
            cached_instances.instance_manager.context.cache_root.to_pathname
              .join('instances', "#{logical_path.parameterize}.yaml")
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
