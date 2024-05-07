# frozen_string_literal: true

require 'ruby-progressbar'
require 'avm/launcher/instances/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Launcher
    class Context
      class InstanceDiscovery
        # @!attribute [r] instances
        #   @return [Array<Avm::Launcher::Instances::Base>]
        attr_reader :instances

        # @!method initialize(context)
        #   @param context [Avm::Launcher::Context]
        common_constructor :context do
          @progress = ::ProgressBar.create(title: 'Instance discovery', total: 1)
          @instances = path_instances(context.root, nil)
        ensure
          @progress&.finish
        end

        private

        # @param path [Avm::Launcher::Paths::Logical]
        # @param parent_instance [Avm::Launcher::Instances::Base]
        # @return [Array<Avm::Launcher::Instances::Base>]
        def path_instances(path, parent_instance)
          update_progress_format(path)
          on_rescued_path_instances(path) do |r|
            if path.project?
              parent_instance = ::Avm::Launcher::Instances::Base.instanciate(path, parent_instance)
              r << path
            end
            children = path.children
            update_progress_count(children)
            r.concat(children.flat_map { |c| path_instances(c, parent_instance) })
          end
        end

        # @param path [Avm::Launcher::Paths::Logical]
        # @return [Array<Avm::Launcher::Instances::Base>]
        def on_rescued_path_instances(path)
          r = []
          begin
            yield(r) if path.included?
          rescue StandardError => e
            warn("#{path}: #{e}")
          end
          r
        end

        # @param path [Avm::Launcher::Paths::Logical]
        # @return [void]
        def update_progress_format(path)
          @progress.format = "%t (Paths: %c/%C, Current: #{path.logical}) |%B| %a"
        end

        # @param path [Array<Avm::Launcher::Paths::Logical>]
        # @return [void]
        def update_progress_count(children)
          @progress.total += children.count
          @progress.increment
        end
      end
    end
  end
end
