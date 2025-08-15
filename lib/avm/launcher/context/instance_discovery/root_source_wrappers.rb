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

          # @return [Enumerable<Avm::Launcher::Context::InstanceDiscovery::SourceWrapper>]
          def result
            owner.root_sources.map do |source|
              ::Avm::Launcher::Context::InstanceDiscovery::SourceWrapper.new(
                owner,
                ::Avm::Launcher::Paths::Logical.new(
                  owner.context, nil, source.to_path, "/#{source.basename}"
                ),
                nil
              )
            end
          end
        end
      end
    end
  end
end
