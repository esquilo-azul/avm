# frozen_string_literal: true

require 'avm/scms/auto_commit/rules/base'
require 'avm/scms/auto_commit/file_resource_name'

module Avm
  module Scms
    module AutoCommit
      module Rules
        class New < ::Avm::Scms::AutoCommit::Rules::Base
          class WithFile < ::Avm::Scms::AutoCommit::Rules::Base::WithFile
            def auto_commit_path
              ::Avm::Scms::AutoCommit::FileResourceName.new(file.scm.path, file.path)
            end

            def commit_info
              new_commit_info.message(auto_commit_path.commit_message)
            end
          end
        end
      end
    end
  end
end
