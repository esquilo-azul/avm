# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module Jobs
      class VariablesSource
        class ReadEntry
          enable_method_class
          common_constructor :variables_source, :path, :options, default: [{}]
          delegate :instance, :job, to: :variables_source

          def result
            result_from_job || result_from_instance_entry
          end

          private

          def path_method_name
            path.gsub('.', '_').underscore
          end

          def result_from_instance_entry
            instance.read_entry(path, options)
          end

          def result_from_job
            return job.send(path_method_name) if job.respond_to?(path_method_name, true)
          end
        end
      end
    end
  end
end
