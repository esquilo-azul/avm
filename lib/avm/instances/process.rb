# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Instances
    class Process
      class << self
        # @return [Symbol]
        def default_id
          name.demodulize.underscore.to_sym
        end
      end

      acts_as_abstract :available?, :disable, :enable
      common_constructor :instance, :id, default: [nil] do
        self.id ||= (id || self.class.default_id).to_sym
      end
    end
  end
end
