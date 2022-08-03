# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    class Base
      module AutoValues
        require_sub __FILE__

        common_concern do
          %w[Admin Data Database Filesystem Install Mailer Ruby Source System Web]
            .each do |class_name|
            include const_get(class_name)
          end
        end
      end
    end
  end
end
