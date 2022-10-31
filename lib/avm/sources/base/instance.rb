# frozen_string_literal: true

require 'avm/applications/base'
require 'avm/instances/base'

module Avm
  module Sources
    class Base
      module Instance
        DEFAULT_INSTANCE_SUFFIX = 'dev'

        def instance_suffix
          DEFAULT_INSTANCE_SUFFIX
        end

        private

        def instance_uncached
          ::Avm::Instances::Base.new(application, DEFAULT_INSTANCE_SUFFIX)
        end
      end
    end
  end
end
