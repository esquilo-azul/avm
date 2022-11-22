# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Stereotype
        STEREOTYPE_NAME_KEY = 'stereotype'

        # @return [String, nil]
        def stereotype_name_by_configuration
          configuration.entry(STEREOTYPE_NAME_KEY).value
        end
      end
    end
  end
end
