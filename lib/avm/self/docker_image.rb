# frozen_string_literal: true

require 'avm/docker/image'

module Avm
  module Self
    class DockerImage < ::Avm::Docker::Image
      def stereotype_tag
        nil
      end
    end
  end
end
