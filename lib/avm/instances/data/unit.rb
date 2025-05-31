# frozen_string_literal: true

require 'avm/data/unit_with_commands'
require 'avm/instances/data/loading_denied_error'
require 'eac_ruby_utils'

module Avm
  module Instances
    module Data
      class Unit < ::Avm::Data::UnitWithCommands
        common_constructor :instance

        # @return [void]
        # @raise Avm::Instances::Data::Unit
        def check_load_permission!
          return if instance.data_allow_loading

          raise ::Avm::Instances::Data::LoadingDeniedError, "Instance: #{instance}"
        end

        # @return [Pathname]
        def data_default_dump_path
          instance.data_default_dump_path.to_pathname.basename_sub('.*') do |b|
            "#{b}_#{identifier}#{dump_path_extension}"
          end
        end

        # @return [String]
        def identifier
          instance.data_package.units.key(self) || raise("No identifier found for #{self}")
        end

        def load(...)
          check_load_permission!
          instance.on_disabled_processes { super }
        end
      end
    end
  end
end
