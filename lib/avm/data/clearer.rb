# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Data
    class Clearer
      enable_speaker

      common_constructor :storage

      # @return [self]
      def perform
        storage.clear
      end
    end
  end
end
