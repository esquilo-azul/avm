# frozen_string_literal: true

module Avm
  module Launcher
    class Context
      class InstanceManager
        class CachedInstances
          enable_memoized
          common_constructor :instance_manager

          memoize def cached_instances
            {}
          end

          # @return [Hash, nil]
          memoize def content
            content_unmemoized
          end

          # @return [Hash, nil]
          def content_unmemoized
            r = YAML.load_file(root_file_path)
            r.is_a?(::Hash) ? r : nil
          rescue Errno::ENOENT
            nil
          end

          # @return [Array<Avm::Launcher::Instances::Base>]
          def instances
            refresh_outdated_instances
            content.keys.map { |k| by_logical_path(k).instance }.compact_blank
          end

          def by_logical_path(key)
            cached_instances[key].if_blank do
              cached_instances[key] = ::Avm::Launcher::Context::InstanceManager::CachedInstance.new(
                self, key
              )
            end
          end

          # @return [String]
          def root_file_path
            ::File.join(instance_manager.context.cache_root, 'instances.yml')
          end

          # @param instances []
          # @return []
          def write_instances(instances)
            write_root_file(write_instances_files(instances))
            instances
          end

          protected

          # @param cached_instance [Avm::Launcher::Context::InstanceManager::CachedInstance]
          # @return [Array<Avm::Launcher::Instances::Base>]
          def rediscovered_instances(cached_instance)
            ::Avm::Launcher::Context::InstanceDiscovery.new(instance_manager.context)
              .instances_from(
                ::Avm::Launcher::Paths::Logical.new(
                  instance_manager.context, nil, cached_instance.path.real,
                  cached_instance.logical_path
                ),
                cached_instance.parent_instance
              )
          end

          # @param cached_instance [Avm::Launcher::Context::InstanceManager::CachedInstance]
          # @return [void]
          def refresh_instance(cached_instance)
            write_root_file(
              content.reject { |key, _| subtree_key?(cached_instance.logical_path, key) }
                .merge(write_instances_files(rediscovered_instances(cached_instance)))
            )
            unmemoize(:content)
          end

          # @return [void]
          def refresh_outdated_instances
            content.keys.sort.each do |key|
              next unless content.key?(key)

              by_logical_path(key).then { |v| refresh_instance(v) if v.outdated? }
            end
          end

          # @param root_key [String]
          # @param key [String]
          # @return [Boolean]
          def subtree_key?(root_key, key)
            key == root_key || key.start_with?("#{root_key}/")
          end

          # @param logical_path [Avm::Launcher::Paths::Logical]
          # @param instance_data [Hash]
          # @return [String]
          def write_instance(logical_path, instance_data)
            cached_instance = by_logical_path(logical_path)
            cached_instance.data = instance_data
            cached_instance.data_path.to_path
          end

          # @param instances [Enumerable<Avm::Launcher::Instances::Base>]
          # @return [Hash<String, String>]
          def write_instances_files(instances)
            instances.to_h { |i| [i.logical, write_instance(i.logical, i.to_h)] }
          end

          # @param cache_file_data [Hash<String, String>]
          # @return [void]
          def write_root_file(cache_file_data)
            root_file_path.to_pathname.parent.mkpath
            ::File.write(root_file_path, cache_file_data.to_yaml)
          end
        end
      end
    end
  end
end
