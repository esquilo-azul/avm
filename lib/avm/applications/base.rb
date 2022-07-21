# frozen_string_literal: true

require 'avm/instances/entries'
require 'eac_ruby_utils/core_ext'

module Avm
  module Applications
    class Base
      enable_simple_cache
      include ::Avm::Instances::Entries

      LOCAL_INSTANCE_SUFFIX = 'dev'

      common_constructor :id do
        self.id = id.to_s
      end

      def to_s
        id
      end

      def instance(suffix)
        ::Avm::Instances::Base.new(self, suffix)
      end

      def name
        entry(::Avm::Instances::EntryKeys::NAME).read
      end

      private

      # @return [Avm::Instances::Base]
      def local_instance_uncached
        instance(LOCAL_INSTANCE_SUFFIX)
      end
    end
  end
end
