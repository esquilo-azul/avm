# frozen_string_literal: true

require 'avm/data/unit'
require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    module Data
      class Unit < ::Avm::Data::Unit
        common_constructor :instance
      end
    end
  end
end
