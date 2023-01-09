# frozen_string_literal: true

require 'avm/registry/from_gems'

module Avm
  module Registry
    class FileFormats < ::Avm::Registry::FromGems
      # @return [Avm::FileFormats::Base]
      def class_detect(klass, detect_args)
        klass.new if klass.new.match?(detect_args.first)
      end
    end
  end
end
