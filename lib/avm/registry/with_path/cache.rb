# frozen_string_literal: true

require 'avm/registry/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Registry
    class WithPath < ::Avm::Registry::Base
      class Cache
        enable_simple_cache
        common_constructor :owner

        def detect_optional(path)
          return nil if path.root?
          return cached_paths.fetch(path) if cached_paths.key?(path)

          detected = owner.detect_optional(path)
          detected = detect_optional(path.parent) if detected.blank?
          cached_paths[path] = detected
          detected
        end

        private

        def cached_paths_uncached
          {}
        end
      end
    end
  end
end
