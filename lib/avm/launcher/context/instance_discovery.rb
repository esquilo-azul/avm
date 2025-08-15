# frozen_string_literal: true

module Avm
  module Launcher
    class Context
      class InstanceDiscovery
        enable_simple_cache

        # @!method instances
        #   @return [Array<Avm::Launcher::Instances::Base>]

        # @!method initialize(context)
        #   @param context [Avm::Launcher::Context]
        common_constructor :context

        private

        # @return [Array<Avm::Launcher::Instances::Base>]
        def instances_uncached
          root_source_wrappers.flat_map(&:projects)
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
