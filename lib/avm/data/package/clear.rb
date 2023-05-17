# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Data
    class Package
      class Clear
        enable_method_class
        enable_speaker
        common_constructor :package

        # @return [void]
        def result
          package.units.each do |identifier, unit|
            infov 'Clearing unit', identifier
            unit.clear
          end
        end
      end
    end
  end
end
