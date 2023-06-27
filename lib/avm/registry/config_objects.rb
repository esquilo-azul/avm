# frozen_string_literal: true

require 'avm/applications/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class Applications
      def initialize(*args); end

      # @return [Array<Avm::Applications::Base>]
      def available
        ::EacConfig::Node.context.current.entries('*.avm_type').node_entries.each do |node_entry|
          detect(node_entry.path.first)
        end
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

      def load_config
        ::EacConfig::Node.context.current.entries('*.avm_type').node_entries.each do |node_entry|
          detect(node_entry.path.first)
        end
      end
    end
  end
end
