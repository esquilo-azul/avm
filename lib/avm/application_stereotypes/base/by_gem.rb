# frozen_string_literal: true

module Avm
  module ApplicationStereotypes
    class Base
      module ByGem
        common_concern

        module ClassMethods
          def by_gem(gem_name)
            new(gem_name.gsub('-', '/').camelize)
          end
        end
      end
    end
  end
end
