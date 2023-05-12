# frozen_string_literal: true

require 'avm/data/unit'
require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    module Data
      class Unit < ::Avm::Data::Unit
        common_constructor :instance

        # @return [String]
        def identifier
          instance.data_package.units.key(self) || raise("No identifier found for #{self}")
        end
      end
    end
  end
end
