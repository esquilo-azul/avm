# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Scms
    class CommitInfo
      enable_immutable

      immutable_accessor :fixup, :message
    end
  end
end
