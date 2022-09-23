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
            entry_from_job || result_from_instance_entry
          end

          private

          def entry_from_job
            method = path.gsub('.', '_').underscore
            return job.send(method) if job.respond_to?(method, true)
          end

          def result_from_instance_entry
            instance.read_entry(path, options)
          end
        end
      end
    end
  end
end
