# frozen_string_literal: true

module Avm
  module Sources
    class Base
      module Update
        # To override in subclasses.
        def on_sub_updated
          # Do nothing
        end

        def update
          update_self_before_subs
          update_subs
        end

        # @return [void]
        def update_self_before_subs
          update_self_changes_before_subs.each do |change|
            scm.commit_if_change(-> { change.commit_message }) do
              change.perform
              parent.if_present(&:on_sub_updated)
            end
          end
        end

        # Changes for update before subs' updating.
        # @return [Enumerable<Avm::Sources::Change>]
        def update_self_changes_before_subs
          []
        end
      end
    end
  end
end
