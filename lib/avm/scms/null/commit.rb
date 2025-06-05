# frozen_string_literal: true

require 'avm/scms/base'
require 'avm/scms/commit'

module Avm
  module Scms
    class Null < ::Avm::Scms::Base
      class Commit < ::Avm::Scms::Commit
        common_constructor :scm
      end
    end
  end
end
