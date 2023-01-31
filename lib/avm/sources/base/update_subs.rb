# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      class UpdateSubs
        enable_method_class

        common_constructor :source

        def result
          source.subs.each { |sub| source.update_sub(sub) }
        end
      end
    end
  end
end
