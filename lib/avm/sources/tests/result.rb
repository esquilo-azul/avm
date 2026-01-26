# frozen_string_literal: true

module Avm
  module Sources
    module Tests
      class Result < ::EacCli::Enum
        enum :failed, :red
        enum :nonexistent, :white
        enum :sucessful, :green
      end
    end
  end
end
