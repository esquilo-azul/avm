# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Data
    class Package
      require_sub __FILE__

      attr_reader :units

      def initialize(options)
        @units = {}
        options = options.to_options_consumer
        units = options.consume(:units)
        options.validate
        units.if_present do |v|
          v.each { |identifier, unit| add_unit(identifier, unit) }
        end
      end

      def add_unit(identifier, unit)
        @units[identifier.to_sym] = unit
      end

      def dump(data_path, options = {})
        ::Avm::Data::Package::Dump.new(self, data_path, options)
      end

      def load(data_path)
        ::Avm::Data::Package::Load.new(self, data_path)
      end

      def dump_units_to_directory(directory)
        @units.each { |identifier, unit| unit.dump_to_directory(directory, identifier) }
      end

      def load_units_from_directory(directory)
        @units.each { |identifier, unit| unit.load_from_directory(directory, identifier) }
      end
    end
  end
end
