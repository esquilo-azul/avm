# frozen_string_literal: true

require 'avm/sources/base/subs_paths'
require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Runners
        # @return [Hash<String, Class>]
        def extra_available_subcommands
          {}
        end
      end
    end
  end
end
