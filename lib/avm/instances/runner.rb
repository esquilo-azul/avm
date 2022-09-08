# frozen_string_literal: true

require 'avm/runners/base'
require 'eac_cli/core_ext'

module Avm
  module Instances
    class Runner < ::Avm::Runners::Base
      class << self
        def stereotype_module
          ::Avm.const_get(stereotype_name)
        end

        def stereotype_name
          name.demodulize
        end
      end

      runner_with :help, :subcommands do
        desc 'Utilities for a instance.'
        pos_arg 'instance-id'
        subcommands
      end

      delegate :class, to: :instance, prefix: true
      delegate :stereotype_module, :stereotype_name, to: :class

      def extra_available_subcommands
        instance.if_present({}, &:extra_available_subcommands)
      end

      private

      def instance_uncached
        parsed.instance_id.if_present { |v| ::Avm::Registry.instances.detect(v) }
      end
    end
  end
end
