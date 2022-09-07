# frozen_string_literal: true

require 'avm/with/application_stereotype'
require 'avm/with/extra_subcommands'
require 'eac_ruby_utils/require_sub'
require 'eac_ruby_utils/simple_cache'
require 'avm/entries/base'

module Avm
  module Instances
    class Base
      enable_abstract_methods
      enable_listable
      enable_simple_cache
      require_sub __FILE__, include_modules: true
      include ::Avm::Entries::Base
      include ::Avm::With::ExtraSubcommands
      include ::Avm::With::ApplicationStereotype

      lists.add_string :access, :local, :ssh

      ID_PATTERN = /\A([a-z0-9]+(?:\-[a-z0-9]+)*)_(.+)\z/.freeze

      class << self
        def by_id(id)
          application_id, suffix = parse_id(id)
          require 'avm/applications/base'
          new(::Avm::Applications::Base.new(application_id), suffix)
        end

        private

        def parse_id(id)
          m = ID_PATTERN.match(id)
          return [m[1], m[2]] if m

          raise "ID Pattern no matched: \"#{id}\""
        end
      end

      common_constructor :application, :suffix do
        self.suffix = suffix.to_s
      end

      def id
        "#{application.id}_#{suffix}"
      end

      def to_s
        id
      end

      def host_env_uncached
        case install_scheme
        when 'file' then ::EacRubyUtils::Envs.local
        when 'ssh' then ::EacRubyUtils::Envs.ssh(install_url)
        else raise("Unmapped access value: \"#{install_scheme}\"")
        end
      end

      private

      def source_instance_uncached
        ::Avm::Instances::Base.by_id(source_instance_id)
      end
    end
  end
end
