# frozen_string_literal: true

require 'avm/data/unit'

module Avm
  module Instances
    module Data
      class Unit < ::Avm::Data::Unit
        attr_reader :instance

        def initialize(instance)
          @instance = instance
        end
      end
    end
  end
end
