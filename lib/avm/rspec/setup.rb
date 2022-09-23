# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Rspec
    module Setup
      EXAMPLES = %w[in_avm_registry not_in_avm_registry].freeze

      def self.extended(obj)
        obj.setup_examples
      end

      def setup_examples
        EXAMPLES.each do |example|
          require "avm/rspec/shared_examples/#{example}"
        end
      end
    end
  end
end
