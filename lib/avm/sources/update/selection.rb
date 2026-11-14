# frozen_string_literal: true

module Avm
  module Sources
    module Update
      # Selects which changes are performed in a source's update and if its subs are updated.
      class Selection
        acts_as_immutable
        immutable_accessor :exclude, :include, type: :set
        immutable_accessor :subs, type: :boolean

        # @param change_id [String]
        # @return [Boolean]
        def selected?(change_id)
          (includes.empty? || includes.include?(change_id.to_s)) &&
            excludes.exclude?(change_id.to_s)
        end

        protected

        # @param value [Set]
        # @return [Set<String>]
        def exclude_get_filter(value)
          value.to_set(&:to_s)
        end

        # @param value [Set]
        # @return [Set<String>]
        def include_get_filter(value)
          value.to_set(&:to_s)
        end

        # @param value [Boolean, nil]
        # @return [Boolean]
        def subs_get_filter(value)
          value.nil? || value.to_bool
        end
      end
    end
  end
end
