# frozen_string_literal: true

module Avm
  module ApplicationStereotypes
    class Base
      module Detection
        common_concern

        module ClassMethods
          # @return [Class<Avm::Sources::Base>, nil]
          def detect(object)
            return singleton_instance if
            %w[name instance_class source_class].any? { |t| send("detect_by_#{t}?", object) }
          end

          # @return [Boolean]
          def detect_by_instance_class?(object)
            object.is_a?(::Class) && singleton_instance.instance_class == object
          end

          # @return [Boolean]
          def detect_by_name?(object)
            object.is_a?(::String) && singleton_instance.name == object
          end

          # @return [Boolean]
          def detect_by_source_class?(object)
            object.is_a?(::Class) && singleton_instance.source_class == object
          end
        end
      end
    end
  end
end
