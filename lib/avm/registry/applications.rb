# frozen_string_literal: true

require 'avm/applications/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class Applications
      def initialize(*args); end

      # @return [Array<Avm::Applications::Base>]
      def available
        detected.values
      end

      # @return [Avm::Applications::Base]
      def detect(id)
        id = id.to_s
        detected[id] = ::Avm::Applications::Base.new(id) unless detected.key?(id)
        detected[id]
      end

      private

      # @return [Hash<String, Avm::Applications::Base>]
      def detected
        @detected ||= {}
      end
    end
  end
end
