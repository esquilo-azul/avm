# frozen_string_literal: true

require 'ruby-progressbar'

module Avm
  module Launcher
    class Context
      class InstanceDiscovery
        class RootSources
          acts_as_instance_method
          enable_speaker

          common_constructor :owner

          # @return [Array<Avm::Launcher::Paths::Logical>]
          def result
            ::Avm::Registry.applications.available.sort_by { |a| [a.id] }.map do |application|
              application_source(application)
            end.compact_blank.uniq.sort
          end

          protected

          # @param application [Avm::Applications::Base]
          # @return [Pathname, nil]
          def application_source(application) # rubocop:disable Metrics/MethodLength
            if application.user_local_source_path.blank?
              warn "Application \"#{application}\" does not have a user local source set"
              nil
            elsif application.user_local_source_path.directory?
              infov application,
                    "user local source found in \"#{application.user_local_source_path}\""
              application.user_local_source_path
            else
              warn "Application \"#{application}\"'s local source path is not a directory"
              nil
            end
          end
        end
      end
    end
  end
end
