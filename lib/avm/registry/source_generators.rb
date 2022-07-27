# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/registry/from_gems'

module Avm
  module Registry
    class SourceGenerators < ::Avm::Registry::FromGems
      # @return [Avm::Instances::Base, nil]
      def class_detect(klass, detect_args)
        stereotype_name, target_path = detect_args
        klass.application_stereotype.name == stereotype_name ? klass.new(target_path) : nil
      end
    end
  end
end
