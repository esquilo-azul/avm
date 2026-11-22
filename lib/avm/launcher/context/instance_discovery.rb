# frozen_string_literal: true

module Avm
  module Launcher
    class Context
      class InstanceDiscovery
        enable_memoized

        # @!method initialize(context)
        #   @param context [Avm::Launcher::Context]
        common_constructor :context

        # @return [Array<Avm::Launcher::Instances::Base>]
        memoize def instances
          root_source_wrappers.flat_map(&:projects)
        end

        # @param logical_path [Avm::Launcher::Paths::Logical]
        # @param parent_project [Avm::Launcher::Instances::Base, nil]
        # @return [Array<Avm::Launcher::Instances::Base>]
        def instances_from(logical_path, parent_project)
          ::Avm::Launcher::Context::InstanceDiscovery::SourceWrapper.new(
            self, logical_path, parent_project
          ).projects
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
