# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    module Ids
      ID_PATTERN = /\A([a-z0-9]+(?:\-[a-z0-9]+)*)_(.+)\z/.freeze
      ID_PARSER = ID_PATTERN.to_parser do |m|
        ::Struct.new(:application_id, :instance_suffix).new(m[1], m[2])
      end

      class << self
        # @param id [String]
        # @return [String]
        def parse!(id)
          ID_PARSER.parse!(id)
        end
      end
    end
  end
end
