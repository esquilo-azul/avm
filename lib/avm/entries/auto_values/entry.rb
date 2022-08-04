# frozen_string_literal: true

require 'eac_config/node'
require 'eac_ruby_utils/core_ext'

module Avm
  module Entries
    module AutoValues
      class Entry
        class << self
          def auto_value_method_name(suffix)
            "auto_#{suffix.to_s.gsub('.', '_')}"
          end
        end

        common_constructor :entries_provider, :suffix

        def auto_value_method
          self.class.auto_value_method_name(suffix)
        end

        def found?
          entries_provider.respond_to?(auto_value_method, true)
        end

        def value
          entries_provider.if_respond(auto_value_method)
        end
      end
    end
  end
end
