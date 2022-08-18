# frozen_string_literal: true

require 'avm/entries/uri_builder'
require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    module EntryKeys
      URI_FIELDS = ::Avm::Entries::UriBuilder::ENTRIES_FIELDS + %w[url]

      class << self
        def all
          all_keys.to_a
        end

        def keys_consts_set(prefix, suffixes)
          if suffixes.is_a?(::Hash)
            keys_consts_set_from_hash(prefix, suffixes)
          elsif suffixes.is_a?(::Enumerable)
            keys_consts_set_from_enum(prefix, suffixes)
          else
            raise "Unmapped suffixes class: #{suffixes.class}"
          end
        end

        def key_const_set(prefix, suffix)
          key = [prefix, suffix].reject(&:blank?).join('.')
          const_set(key.gsub('.', '_').upcase, key)
          all_keys << key
        end

        private

        def all_keys
          @all_keys ||= ::Set.new
        end

        def keys_consts_set_from_enum(prefix, suffixes)
          suffixes.each { |suffix| key_const_set(prefix, suffix) }
        end

        def keys_consts_set_from_hash(prefix, suffixes)
          suffixes.each { |k, v| keys_consts_set(prefix.to_s + (k.blank? ? '' : ".#{k}"), v) }
        end
      end

      {
        '' => %w[name source_instance_id],
        admin: URI_FIELDS + %w[api_key],
        database: URI_FIELDS + %w[id limit name system timeout extra],
        docker: %w[registry],
        install: URI_FIELDS + %w[id data_path groupname],
        mailer: {
          '' => %w[id from reply_to],
          smtp: URI_FIELDS + %w[address domain authentication openssl_verify_mode starttls_auto tls]
        },
        web: URI_FIELDS + %w[authority userinfo]
      }.each { |prefix, suffixes| keys_consts_set(prefix, suffixes) }
    end
  end
end
