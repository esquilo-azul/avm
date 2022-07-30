# frozen_string_literal: true

require 'avm/with/application_stereotype'
require 'eac_ruby_utils/core_ext'

module Avm
  module SourceGenerators
    class Base
      include ::Avm::With::ApplicationStereotype
      common_constructor :target_path do
        self.target_path = target_path.to_pathname
      end

      def perform
        assert_clear_directory
        apply_template
      end

      def assert_clear_directory
        target_path.mkpath
        raise "\"#{target_path}\" is not empty" if target_path.children.any?
      end

      def apply_template
        template.apply(self, target_path)
      end
    end
  end
end
