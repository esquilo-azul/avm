# frozen_string_literal: true

require 'ruby-progressbar'

module Avm
  module Launcher
    class Context
      class InstanceDiscovery
        class SourceWrapper
          enable_memoized
          enable_speaker

          common_constructor :owner, :logical_path, :parent_project

          # @return [Avm::Launcher::Instances::Base, nil]
          def parent_project_for_sub
            self_project.presence || parent_project
          end

          # @return [Enumerable<Avm::Launcher::Instances::Base>]
          def projects
            self_project.if_present([]) { |v| [v] } +
              subs.flat_map(&:projects)
          end

          # @return [Avm::Launcher::Instances::Base, nil]
          memoize def self_project
            return nil unless logical_path.project?

            infov logical_path, logical_path.real
            ::Avm::Launcher::Instances::Base.instanciate(logical_path,
                                                         parent_project)
          end

          # @param sub [Avm::Sources::base]
          # @return [Avm::Launcher::Context::InstanceDiscovery::SourceWrapper]
          def sub_wrapper(sub)
            ::Avm::Launcher::Context::InstanceDiscovery::SourceWrapper.new(
              owner,
              logical_path.build_child(sub.relative_path),
              parent_project_for_sub
            )
          end

          # @return [Enumerable<Avm::Launcher::Instances::Base>]
          def subs
            warped_source.subs.map { |sub| sub_wrapper(sub) }
          rescue StandardError => e
            warn("#{logical_path}: #{e}")
            []
          end

          # @return [Avm::Sources::Base]
          memoize def warped_source
            ::Avm::Registry.sources.detect(logical_path.warped)
          end
        end
      end
    end
  end
end
