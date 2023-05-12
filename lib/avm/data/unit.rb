# frozen_string_literal: true

require 'avm/data/callbacks'
require 'eac_ruby_utils/core_ext'

module Avm
  module Data
    class Unit
      acts_as_abstract(
        do_dump: [:dump_path],
        do_load: [:dump_path],
        dump_path_extension: []
      )
      enable_speaker
      include ::Avm::Data::Callbacks

      # @param dump_path [Pathname]
      # @return [void]
      def dump(dump_path)
        run_callbacks :dump do
          infom "Dumping unit \"#{name}\" to \"#{dump_path}\"..."
          do_dump(dump_path)
        end
      end

      # @param dump_path [Pathname]
      # @return [void]
      def load(dump_path)
        run_callbacks :load do
          infom "Loading unit \"#{name}\" from \"#{dump_path}\"..."
          do_load(dump_path)
        end
      end

      # @return [String]
      def name
        self.class.name
      end
    end
  end
end
