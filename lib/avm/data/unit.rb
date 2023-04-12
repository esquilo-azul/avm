# frozen_string_literal: true

require 'avm/data/callbacks'
require 'eac_ruby_utils/core_ext'

module Avm
  module Data
    class Unit
      include ::Avm::Data::Callbacks

      enable_speaker

      %w[dump load].each do |action|
        method_name = "#{action}_command"
        class_eval <<~CODE, __FILE__, __LINE__ + 1
          # Should be overrided.
          # @return [EacRubyUtils::Envs::Command]
          def #{method_name}
            fail "\\"#{method_name}\\" is a abstract method. Override in #{singleton_class}."
          end
        CODE
      end

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
