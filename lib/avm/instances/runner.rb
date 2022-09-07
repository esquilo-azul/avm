# frozen_string_literal: true

require 'avm/runners/base'
require 'eac_cli/core_ext'

module Avm
  module Instances
    class Runner < ::Avm::Runners::Base
      class << self
        delegate :instance_class, to: :application_stereotype

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

      delegate :instance_class, :stereotype_module, :stereotype_name, to: :class

      def extra_available_subcommands
        instance.if_present({}, &:extra_available_subcommands)
      end

      private

      def instance_uncached
        self.class.instance_class.by_id(parsed.instance_id)
      end
    end
  end
end
