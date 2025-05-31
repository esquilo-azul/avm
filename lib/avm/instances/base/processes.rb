# frozen_string_literal: true

require 'eac_ruby_utils'

module Avm
  module Instances
    class Base
      module Processes
        # @return [Array<Avm::Instances::Process>]
        def available_processes
          processes.select(&:available?)
        end

        def on_disabled_processes(&block)
          available_processes.inject(block) do |a, e|
            -> { e.on_disabled(&a) }
          end.call
        end

        # @return [Array<Avm::Instances::Process>]
        def processes
          []
        end
      end
    end
  end
end
