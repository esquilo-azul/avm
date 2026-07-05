# frozen_string_literal: true

module Avm
  module Sources
    class Base
      module Update
        common_concern do
          enable_speaker
        end

        # To override in subclasses.
        def on_sub_updated
          # Do nothing
        end

        # @return [void]
        def update
          update_self_before_subs
          update_subs
          update_self_after_subs
        end

        # @param changes [Enumerable<Avm::Sources::Change>]
        # @return [void]
        def update_self(changes)
          changes.each { |change| update_self_with_change(change) }
        end

        # @return [void]
        def update_self_after_subs
          infov __method__, self
          update_self(update_self_changes_after_subs)
        end

        # @return [void]
        def update_self_before_subs
          infov __method__, self
          update_self(update_self_changes_before_subs)
        end

        # Changes for update after subs' updating.
        # @return [Enumerable<Avm::Sources::Change>]
        def update_self_changes_after_subs
          []
        end

        # Changes for update before subs' updating.
        # @return [Enumerable<Avm::Sources::Change>]
        def update_self_changes_before_subs
          []
        end

        # @param change [Avm::Sources::Change]
        # @return [void]
        def update_self_with_change(change)
          infov 'Performing change', change
          scm.commit_if_change(-> { change.commit_message }) do
            change.perform
            parent.if_present(&:on_sub_updated)
          end
        end
      end
    end
  end
end
