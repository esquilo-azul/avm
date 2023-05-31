# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    class Base
      module Processes
        # @return [Array<Avm::Instances::Process>]
        def available_processes
          processes.select(&:available?)
        end

        def on_disabled_processes(&block)
          available_processes.each(&:disable)
          block.call
          available_processes.each(&:enable)
        end

        # @return [Array<Avm::Instances::Process>]
        def processes
          []
        end
      end
    end
  end
end
