# frozen_string_literal: true

require 'avm/scms/auto_commit/rules/base'

module Avm
  module Scms
    module AutoCommit
      module Rules
        class Unique < ::Avm::Scms::AutoCommit::Rules::Base
          class WithFile < ::Avm::Scms::AutoCommit::Rules::Base::WithFile
            def commit_info
              return nil unless file.commits.count == 1

              new_commit_info.fixup(file.commits.first)
            end
          end
        end
      end
    end
  end
end
