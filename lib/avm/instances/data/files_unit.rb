# frozen_string_literal: true

require 'avm/instances/data/unit'

module Avm
  module Instances
    module Data
      class FilesUnit < ::Avm::Instances::Data::Unit
        EXTENSION = '.tar.gz'

        common_constructor :instance, :fs_path_subpath, super_args: -> { [instance] }

        before_load :clear_files

        def files_path
          ::File.join(instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH),
                      fs_path_subpath)
        end

        def dump_command
          instance_command('tar', '-czf', '-', '-C', files_path, '.')
        end

        def load_command
          instance_command('tar', '-xzf', '-', '-C', files_path)
        end

        def clear_files
          infom "Removing all files under #{files_path}..."
          instance_command('mkdir', '-p', files_path).execute!
          instance_command('find', files_path, '-mindepth', 1, '-delete').execute!
        end

        # @return [EacRubyUtils::Envs::Command]
        def instance_command(*args)
          instance.host_env.command(*args)
        end
      end
    end
  end
end
