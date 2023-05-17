# frozen_string_literal: true

require 'avm/self/instance'

module Avm
  module Instances
    class Base
      module AutoValues
        module Data
          def auto_data_default_dump_path
            ::Avm::Self::Instance
              .default
              .read_entry_optional(::Avm::Self::Instance::EntryKeys::DATA_DEFAULT_PATH)
              .if_present do |v|
              ::File.join(
                v,
                "#{id}#{data_package.data_file_extension}"
              )
            end
          end
        end
      end
    end
  end
end
