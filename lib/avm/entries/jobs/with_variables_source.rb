# frozen_string_literal: true

require 'avm/entries/jobs/variables_source'

module Avm
  module Entries
    module Jobs
      module WithVariablesSource
        def variables_source
          ::Avm::Entries::Jobs::VariablesSource.new(self)
        end
      end
    end
  end
end
