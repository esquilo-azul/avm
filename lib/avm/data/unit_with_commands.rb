# frozen_string_literal: true

require 'avm/data/callbacks'
require 'eac_ruby_utils/core_ext'

module Avm
  module Data
    class UnitWithCommands
      include ::Avm::Data::Callbacks

      acts_as_abstract
      enable_speaker

      abstract_method :dump_command
      abstract_method :load_command

      def extension
        singleton_class.const_get('EXTENSION')
      rescue NameError
        ''
      end

      def name
        self.class
      end

      def load_from_directory(directory, identifier)
        load(unit_on_directory_path(directory, identifier))
      end

      def dump_to_directory(directory, identifier)
        dump(unit_on_directory_path(directory, identifier))
      end

      def dump(data_path)
        run_callbacks :dump do
          infom "Dumping unit \"#{name}\" to \"#{data_path}\"..."
          do_dump(data_path)
        end
      end

      # @return [Struct(:key, :subpath), nil]
      def installation_files_data
        nil
      end

      def load(data_path)
        run_callbacks :load do
          infom "Loading unit \"#{name}\" from \"#{data_path}\"..."
          do_load(data_path)
        end
      end

      protected

      def do_dump(data_path)
        dump_command.execute!(output_file: data_path)
      end

      def do_load(data_path)
        load_command.execute!(input_file: data_path)
      end

      private

      def unit_on_directory_path(directory, identifier)
        ::File.join(directory, "#{identifier}#{extension}")
      end
    end
  end
end
