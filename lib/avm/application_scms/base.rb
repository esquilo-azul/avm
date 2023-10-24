# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module ApplicationScms
    class Base
      class << self
        # @return [String]
        def type_name
          name.gsub(/#{Regexp.quote('::ApplicationScms::Base')}$/, '').demodulize
        end
      end

      # !method initialize(url)
      # @param url [Addressable::URI]
      common_constructor :url do
        self.url = url.to_uri
      end
      delegate :type_name, to: :class

      # @return [String]
      def to_s
        "#{type_name}[#{url}]"
      end
    end
  end
end
