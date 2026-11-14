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

        # @param selection [Avm::Sources::Update::Selection]
        # @return [void]
        def update(selection = ::Avm::Sources::Update::Selection.new)
          ::Avm::Sources::Update::Base.new(self, selection).perform
        end

        # Identifiers of the changes selectable by a {Avm::Sources::Update::Selection}, in
        # execution order.
        # @return [Array<String>]
        def update_changes_ids
          (update_self_changes_before_subs + update_self_changes_after_subs).map(&:id)
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
      end
    end
  end
end
