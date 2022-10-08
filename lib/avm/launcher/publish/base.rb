# frozen_string_literal: true

require 'avm/launcher/errors/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Launcher
    module Publish
      class Base
        common_constructor :instance

        def run
          s = check
          info("Check: #{s}")
          return unless s.status == ::Avm::Launcher::Publish::CheckResult::STATUS_PENDING

          publish
        end

        def check
          s = check_with_rescue
          ::Avm::Launcher::Context.current.instance_manager.publish_state_set(
            instance, stereotype.stereotype_name, s.status
          )
          s
        end

        private

        def stereotype
          self.class.name.deconstantize.constantize
        end

        def check_with_rescue
          internal_check
        rescue ::Avm::Launcher::Errors::Base => e
          ::Avm::Launcher::Publish::CheckResult.blocked("Error: #{e}")
        end
      end
    end
  end
end
