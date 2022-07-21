# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class ApplicationStereotypes
      require_sub __FILE__, require_dependency: true
      enable_simple_cache

      common_constructor :module_suffix

      private

      def available_uncached
        build_available
      end

      # @return [Avm::Instances::Base, nil]
      def class_detect(klass, detect_args)
        r = ::Avm::Instances::Base.by_id(*detect_args)
        r.application.stereotype.instance_class == klass ? r : nil
      end

      def detect(*registered_initialize_args)
        detect_optional(*registered_initialize_args) ||
          raise_not_found(*registered_initialize_args)
      end

      def detect_optional(*registered_initialize_args)
        registered_modules.reverse.lazy
          .map { |klass| class_detect(klass, registered_initialize_args) }.find(&:present?)
      end
    end
  end
end
