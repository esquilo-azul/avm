# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Applications
    class Base
      module Naming
        # @return [String]
        def name
          entry(::Avm::Instances::EntryKeys::NAME).read
        end
      end
    end
  end
end