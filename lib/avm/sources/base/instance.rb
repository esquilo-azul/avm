# frozen_string_literal: true

require 'avm/applications/base'
require 'avm/instances/base'

module Avm
  module Sources
    class Base
      module Instance
        def instance
          application.local_instance
        end
      end
    end
  end
end
