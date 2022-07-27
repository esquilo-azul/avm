# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/gems_registry'

module Avm
  module Registry
    require_sub __FILE__
    enable_listable
    lists.add_symbol :category, :application_stereotypes, :instances, :runners, :scms,
                     :source_generators, :sources

    WITH_PATH = [CATEGORY_SCMS, CATEGORY_SOURCES].freeze

    class << self
      enable_simple_cache

      # @return [Array<Avm::Registry::FromGems>]
      def registries
        lists.category.values.map { |c| send(c) }
      end

      private

      ::Avm::Registry.lists.category.each_value do |category|
        define_method "#{category}_uncached" do
          registry_class(category).new(category.to_s.camelize)
        end
      end

      def registry_class(category)
        ::Avm::Registry.const_get(category.to_s.camelize)
      end
    end
  end
end
