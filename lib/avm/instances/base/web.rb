# frozen_string_literal: true

require 'addressable'
require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module Web
        common_concern do
          uri_components_entries_values 'web'
        end
      end
    end
  end
end
