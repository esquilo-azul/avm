# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Scms
    class CommitInfo
      enable_immutable

      immutable_accessor :fixup, :message
      immutable_accessor :path, type: :array

      def to_s
        self.class.name.demodulize + '[' +
          %w[fixup message].map { |m| [m, send(m)] }.reject { |m| m[1].blank? }
            .map { |m| m.join(': ') }.join(',') + ']'
      end
    end
  end
end
