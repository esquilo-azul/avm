# frozen_string_literal: true

require 'avm/entries/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Applications
    class Base
      enable_simple_cache
      require_sub __FILE__, include_modules: true
      include ::Avm::Entries::Base

      AVM_TYPE = 'Application'

      common_constructor :id do
        self.id = id.to_s
      end

      def to_s
        id
      end

      def instance(suffix)
        stereotype.instance_class.new(self, suffix)
      end
    end
  end
end
