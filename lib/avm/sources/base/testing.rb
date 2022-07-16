# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Testing
        DEFAULT_TEST_COMMANDS = {}.freeze
        TEST_KEY = 'test'
        TEST_COMMAND_KEY = "#{TEST_KEY}.command"

        def configured_test_command
          read_configuration_as_env_command(TEST_COMMAND_KEY)
        end

        # @return [Hash<String, EacRubyUtils::Envs::Command>]
        def default_test_commands
          DEFAULT_TEST_COMMANDS
        end

        # @return [Avm::Sources::Tester]
        def tester
          tester_class.new(self)
        end

        # @return [Class<Avm::Sources::Tester>
        def tester_class
          Avm::Sources::Tester
        end
      end
    end
  end
end
