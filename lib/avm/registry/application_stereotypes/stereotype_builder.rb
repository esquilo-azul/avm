# frozen_string_literal: true

require 'avm/application_stereotypes/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class ApplicationStereotypes
      class StereotypeBuilder
        common_constructor :namespace_module

        def add_object(type, object)
          attr_method = "#{type}_class"
          raise "#{attr_method} is already present" if send(attr_method).present?

          send("#{attr_method}=", object)
        end

        # @return [Avm::ApplicationStereotypes::Base]
        def build
          ::Avm::ApplicationStereotypes::Base.new(namespace_module, instance_class, source_class)
        end

        private

        attr_accessor :instance_class, :source_class
      end
    end
  end
end
