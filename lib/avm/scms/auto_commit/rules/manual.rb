# frozen_string_literal: true

require 'avm/scms/auto_commit/rules/base'

module Avm
  module Scms
    module AutoCommit
      module Rules
        class Manual < ::Avm::Scms::AutoCommit::Rules::Base
          class WithFile < ::Avm::Scms::AutoCommit::Rules::Base::WithFile
            enable_speaker

            COMMIT_FORMAT = '%h - %s (%cr)'
            SKIP_OPTION = 's'

            def commit_info
              return nil unless file.commits.any?

              commits_banner
              input('Which commit?', list: commits_by_position).if_present do |v|
                new_commit_info.fixup(v)
              end
            end

            def commits_banner
              file.commits.each_with_index do |commit, _index|
                infov "    #{commit.position}", format_commit(commit)
              end
              infov "    #{SKIP_OPTION}", 'skip'
            end

            def commits_by_position
              (file.commits.map { |commit| [commit.position.to_s, commit] } + [[SKIP_OPTION, nil]])
                .to_h
            end

            def format_commit(commit)
              commit.format(COMMIT_FORMAT)
            end
          end
        end
      end
    end
  end
end
