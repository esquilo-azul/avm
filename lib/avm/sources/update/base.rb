# frozen_string_literal: true

module Avm
  module Sources
    module Update
      # Performs the update of a source.
      class Base
        enable_speaker

        # @!method initialize(source, selection = Avm::Sources::Update::Selection.new)
        #   @param source [Avm::Sources::Base]
        #   @param selection [Avm::Sources::Update::Selection]
        common_constructor :source, :selection,
                           default: [::Avm::Sources::Update::Selection.new]

        # @return [void]
        def perform
          update_self_before_subs
          source.update_subs if selection.subs?
          update_self_after_subs
        end

        protected

        # @param changes [Enumerable<Avm::Sources::Change>]
        # @return [void]
        def update_self(changes)
          changes.select { |change| selection.selected?(change.id) }
            .each { |change| update_self_with_change(change) }
        end

        # @return [void]
        def update_self_after_subs
          update_self(source.update_self_changes_after_subs)
        end

        # @return [void]
        def update_self_before_subs
          update_self(source.update_self_changes_before_subs)
        end

        # @param change [Avm::Sources::Change]
        # @return [void]
        def update_self_with_change(change)
          infov "Change[#{change.class}]", change.source
          source.scm.commit_if_change(-> { change.commit_message }) do
            change.perform
            source.parent.if_present(&:on_sub_updated)
          end
        end
      end
    end
  end
end
