# frozen_string_literal: true

require 'eac_cli/runner/context'
require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    class Base
      class SubcommandParent
        enable_simple_cache
        common_constructor :instance

        private

        def runner_context_uncached
          ::EacCli::Runner::Context.new(self, argv: runner_argv)
        end

        def runner_argv
          [instance.class.name.split('::')[-2].dasherize, instance.id]
        end
      end
    end
  end
end
