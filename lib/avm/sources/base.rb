# frozen_string_literal: true

require 'avm/registry'
require 'avm/scms/null'
require 'avm/with_application_stereotype'
require 'avm/with_dynamic_runners'
require 'eac_git'
require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      require_sub __FILE__, include_modules: true
      include ::Avm::WithApplicationStereotype
      include ::Avm::WithDynamicRunners
      compare_by :path
      enable_abstract_methods
      enable_simple_cache
      enable_listable
      lists.add_symbol :option, :parent
      common_constructor :path, :options, default: [{}] do
        self.path = path.to_pathname.expand_path
        self.options = ::Avm::Sources::Base.lists.option.hash_keys_validate!(options)
      end

      abstract_methods :update, :valid?

      # @return [EacRubyUtils::Envs::LocalEnv]
      def env
        ::EacRubyUtils::Envs::LocalEnv.new
      end

      # @return [Pathname]
      def relative_path
        return path if parent.blank?

        path.relative_path_from(parent.path)
      end

      def to_s
        "#{self.class}[#{path}]"
      end

      private

      # @return [Avm::Scms::Base]
      def scm_uncached
        ::Avm::Registry.scms.detect_optional(path) || ::Avm::Scms::Null.new(path)
      end
    end
  end
end
