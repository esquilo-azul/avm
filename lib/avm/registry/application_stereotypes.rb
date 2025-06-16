# frozen_string_literal: true

module Avm
  module Registry
    class ApplicationStereotypes
      require_sub __FILE__, require_dependency: true
      enable_simple_cache

      common_constructor :module_suffix

      def detect(obj)
        detect_optional(obj) || raise_not_found(obj)
      end

      def detect_optional(obj)
        detect_by_instance_class(obj) || detect_by_source_class(obj) || detecy_by_name(obj)
      end

      private

      def available_uncached
        build_available
      end

      def detect_by_instance_class(obj)
        return nil unless obj.is_a?(::Class) && obj < ::Avm::Instances::Base

        available.find { |a| a.instance_class == obj }
      end

      def detecy_by_name(obj)
        return nil unless obj.is_a?(::String)

        available.find { |a| a.name == obj }
      end

      def detect_by_source_class(obj)
        return nil unless obj.is_a?(::Class) && obj < ::Avm::Sources::Base

        available.find { |a| a.source_class == obj }
      end

      def raise_not_found(obj)
        raise("No registered module valid for #{obj} (Available: #{available.join(', ')})")
      end
    end
  end
end
