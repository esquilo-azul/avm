# frozen_string_literal: true

require 'eac_ruby_utils/envs'
require 'eac_ruby_utils/simple_cache'

module Avm
  module Executables
    class << self
      include ::EacRubyUtils::SimpleCache

      def env
        ::EacRubyUtils::Envs.local
      end

      private

      %w[latex php-cs-fixer yapf xdg-open].each do |program|
        define_method(program.underscore + '_uncached') do
          env.executable(program, '--version')
        end
      end
    end
  end
end
