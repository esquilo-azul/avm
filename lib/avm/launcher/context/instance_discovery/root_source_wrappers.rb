# frozen_string_literal: true

require 'ruby-progressbar'

module Avm
  module Launcher
    class Context
      class InstanceDiscovery
        class RootSourceWrappers
          acts_as_instance_method
          enable_speaker

          common_constructor :owner

          # @return [Array<Avm::Launcher::Paths::Logical>]
          def result
            owner.root_sources.map do |source|
              ::Avm::Launcher::Paths::Logical.new(owner.context, nil, source.to_path,
                                                  "/#{source.basename}")
            end
          end
        end
      end
    end
  end
end
