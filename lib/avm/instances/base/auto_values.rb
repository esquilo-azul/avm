# frozen_string_literal: true

require 'eac_ruby_utils'

module Avm
  module Instances
    class Base
      module AutoValues
        require_sub __FILE__, include_modules: true
        common_concern
      end
    end
  end
end
