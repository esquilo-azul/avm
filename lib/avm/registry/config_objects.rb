# frozen_string_literal: true

require 'avm/applications/base'
require 'eac_ruby_utils'

module Avm
  module Registry
    class ConfigObjects
      def initialize(*args); end

      # @return [Array<Avm::Applications::Base>]
      def available
        ::EacConfig::Node.context.current.entries('*.avm_type').node_entries
          .map { |ne| [ne.path.first, ne.value] }
      end
    end
  end
end
