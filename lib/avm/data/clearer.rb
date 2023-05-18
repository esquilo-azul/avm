# frozen_string_literal: true

require 'avm/data/performer'
require 'eac_ruby_utils/core_ext'

module Avm
  module Data
    class Clearer < ::Avm::Data::Performer
      def cannot_perform_reason
        nil
      end

      protected

      def internal_perform
        data_owner.clear(*include_excludes_arguments)
      end
    end
  end
end
