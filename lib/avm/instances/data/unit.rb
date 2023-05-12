# frozen_string_literal: true

require 'avm/data/unit_with_commands'
require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    module Data
      class Unit < ::Avm::Data::UnitWithCommands
        common_constructor :instance

        # @return [Pathname]
        def data_default_dump_path
          instance.data_default_dump_path.to_pathname.basename_sub('.*') do |b|
            "#{b}_#{identifier}#{extension}"
          end
        end

        # @return [String]
        def identifier
          instance.data_package.units.key(self) || raise("No identifier found for #{self}")
        end
      end
    end
  end
end
