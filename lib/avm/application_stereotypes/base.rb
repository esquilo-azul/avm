# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module ApplicationStereotypes
    class Base
      enable_listable
      lists.add_symbol :resource, :instance, :source
      common_constructor :namespace_module, :instance_class, :source_class

      # @return [String]
      def name
        namespace_module.name.demodulize
      end

      # @return [String]
      def to_s
        name
      end
    end
  end
end
