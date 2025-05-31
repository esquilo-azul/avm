# frozen_string_literal: true

require 'avm/scms/base'
require 'eac_ruby_utils'

module Avm
  module Scms
    class Null < ::Avm::Scms::Base
      require_sub __FILE__

      # @return [Avm::Scms::Null::Commit]
      def head_commit
        @head_commit ||= Avm::Scms::Null::Commit.new(self)
      end

      def update
        # Do nothing
      end
    end
  end
end
