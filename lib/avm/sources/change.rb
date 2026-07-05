# frozen_string_literal: true

module Avm
  module Sources
    class Change
      acts_as_abstract
      common_constructor :source

      # Message for the commit.
      # @return [String]
      def commit_message
        i18n_translate(__method__)
      end

      # Apply the changes to the source.
      # @return [void]
      def perform
        raise_abstract_method __method__
      end
    end
  end
end
