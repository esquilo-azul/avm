# frozen_string_literal: true

require 'avm/data/package/build_directory'
require 'avm/data/rotate'
require 'eac_ruby_utils/core_ext'
require 'minitar'

module Avm
  module Data
    class Package
      class Dump
        enable_speaker
        enable_listable
        include ::Avm::Data::Package::BuildDirectory

        DEFAULT_EXPIRE_TIME = 1.day

        attr_reader :package, :data_file_path, :existing

        lists.add_string :existing, :denied, :overwrite, :rotate, :rotate_expired

        def initialize(package, data_file_path, options = {})
          @package = package
          @data_file_path = data_file_path
          options = options.to_options_consumer
          @existing, @expire_time = options.consume(:existing, :expire_time)
          options.validate
          self.class.lists.existing.value_validate!(@existing)
        end

        def runnable?
          cannot_run_reason.blank?
        end

        def cannot_run_reason
          return nil if !data_file_exist? ||
                        [EXISTING_OVERWRITE, EXISTING_ROTATE].include?(existing)

          if existing == EXISTING_DENIED
            'Data exist and overwriting is denied'
          elsif existing == EXISTING_ROTATE_EXPIRED && !data_file_expired?
            'Data exist and yet is not expired'
          end
        end

        def run
          raise "Cannot run: #{cannot_run_reason}" unless runnable?

          package_file = on_build_directory do
            dump_units_to_build_directory
            create_package_file
          end
          rotate
          move_download_to_final_dest(package_file)
        end

        def data_file_exist?
          ::File.exist?(data_file_path)
        end

        def data_file_time
          data_file_exist? ? ::Time.now - ::File.mtime(data_file_path) : nil
        end

        def data_file_expired?
          data_file_time.if_present(false) { |v| v >= expire_time }
        end

        def expire_time
          @expire_time || DEFAULT_EXPIRE_TIME
        end

        private

        def move_download_to_final_dest(download_path)
          ::FileUtils.mkdir_p(::File.dirname(data_file_path))
          ::FileUtils.mv(download_path, data_file_path)
        end

        def rotate
          return unless data_file_exist?
          return unless existing == EXISTING_ROTATE

          infom "Rotating \"#{data_file_path}\"..."
          ::Avm::Data::Rotate.new(data_file_path).run
        end

        def new_build_path
          f = ::Tempfile.new(self.class.name.parameterize + '-download')
          path = f.path
          f.close
          f.unlink
          path
        end

        def dump_units_to_build_directory
          package.dump_units_to_directory(build_directory)
        end

        def create_package_file
          package_path = new_build_path
          infom "Creating package \"#{package_path}\" from \"#{build_directory}\"..."
          ::Dir.chdir(build_directory.to_path) do
            ::Minitar.pack('.', File.open(::File.expand_path(package_path), 'wb'))
          end
          package_path
        end
      end
    end
  end
end
