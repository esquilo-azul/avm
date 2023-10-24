# frozen_string_literal: true

require 'avm/registry/from_gems'

module Avm
  module Registry
    class ApplicationScms < ::Avm::Registry::FromGems
      def class_detect(klass, detect_args)
        return nil unless klass.type_name == detect_args[0]

        klass.new(*detect_args[1..-1])
      end
    end
  end
end
