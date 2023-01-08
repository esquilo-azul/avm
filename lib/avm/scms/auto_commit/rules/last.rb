# frozen_string_literal: true

require 'avm/scms/auto_commit/rules/base'

module Avm
  module Scms
    module AutoCommit
      module Rules
        class Last < ::Avm::Scms::AutoCommit::Rules::Base
          class WithFile < ::Avm::Scms::AutoCommit::Rules::Base::WithFile
            def commit_info
              file.commits.last.if_present { |v| new_commit_info.fixup(v) }
            end
          end
        end
      end
    end
  end
end
