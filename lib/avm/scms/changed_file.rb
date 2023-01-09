# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Scms
    class ChangedFile
      enable_abstract_methods

      # @return [Pathname]
      def absolute_path
        path.expand_path(scm.path)
      end

      # @return [Pathname]
      def path
        raise_abstract_method __method__
      end

      # @return [Avm::Scms::Base]
      def scm
        raise_abstract_method __method__
      end
    end
  end
end
