# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Scms
    class CommitInfo
      enable_immutable

      immutable_accessor :fixup, :message
      immutable_accessor :path, type: :array
    end
  end
end
