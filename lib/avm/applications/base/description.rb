# frozen_string_literal: true

module Avm
  module Applications
    class Base
      module Description
        DESCRIPTION_ENTRY_PATH = 'description'
        SOURCE_DESCRIPTION_METHOD = :description

        # @return [String, nil]
        def description
          description_from_config || description_from_source
        end

        # @return [String, nil]
        def description_from_config
          entry('description').value
        end

        # @return [String, nil]
        def description_from_source
          local_source.if_respond(SOURCE_DESCRIPTION_METHOD, nil)
        end
      end
    end
  end
end
