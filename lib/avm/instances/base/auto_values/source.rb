# frozen_string_literal: true

require 'avm/applications/base/local_instance'

module Avm
  module Instances
    class Base
      module AutoValues
        module Source
          def auto_source_instance_id
            [application.id, ::Avm::Applications::Base::LocalInstance::LOCAL_INSTANCE_SUFFIX]
              .join('_')
          end
        end
      end
    end
  end
end
