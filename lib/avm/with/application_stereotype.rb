# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module With
    module ApplicationStereotype
      common_concern

      module ClassMethods
        # @return [Avm::ApplicationStereotype::Base]
        def application_stereotype
          @application_stereotype ||=
            ::Avm::Registry.application_stereotypes.detect(application_stereotype_name)
        end

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
end
