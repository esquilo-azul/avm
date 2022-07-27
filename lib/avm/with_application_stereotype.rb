# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module WithApplicationStereotype
    common_concern do
      include ClassMethods
    end

    module ClassMethods
      # @return [String]
      def application_stereotype_name
        stereotype_namespace_module.name.demodulize
      end

      # @return [Module]
      def stereotype_namespace_module
        module_parent.module_parent
      end
    end

    def stereotype_namespace_module
      self.class.stereotype_namespace_module
    end
  end
end
