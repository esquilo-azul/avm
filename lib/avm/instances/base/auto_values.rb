# frozen_string_literal: true

require 'eac_ruby_utils/require_sub'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Instances
    class Base
      module AutoValues
        extend ::ActiveSupport::Concern

        included do
          %w[Admin Data Database Filesystem Install Mailer Ruby Source System Web]
            .each do |class_name|
            include const_get(class_name)
          end
        end
      end
    end
  end
end
