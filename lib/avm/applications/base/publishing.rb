# frozen_string_literal: true

require 'avm/registry'
require 'eac_ruby_utils/blank_not_blank'
require 'eac_ruby_utils/core_ext'

module Avm
  module Applications
    class Base
      module Publishing
        PUBLISHABLE_KEY = 'publishable'

        def publishable?
          publishable_value ? true : false
        end

        def stereotype_publishable?(stereotype)
          return publishable? unless publishable_value.is_a?(::Hash)

          parse_publishable_value(publishable_value[stereotype.stereotype_name], true)
        end

        private

        def publishable_value
          parse_publishable_value(entry(PUBLISHABLE_KEY).optional_value, false)
        end

        def parse_publishable_value(value, hash_to_true) # rubocop:disable Metrics/CyclomaticComplexity
          return value.with_indifferent_access if parse_publishable_value_hash?(value, hash_to_true)
          return true if value.nil? || value == true
          return false if value == false || value.is_a?(::EacRubyUtils::BlankNotBlank)

          value ? true : false
        end

        def parse_publishable_value_hash?(value, hash_to_true)
          !hash_to_true && value.is_a?(::Hash)
        end
      end
    end
  end
end
