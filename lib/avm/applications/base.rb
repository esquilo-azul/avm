# frozen_string_literal: true

require 'avm/instances/entries'
require 'eac_ruby_utils/core_ext'

module Avm
  module Applications
    class Base
      include ::Avm::Instances::Entries

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
    end
  end
end
