# frozen_string_literal: true

require 'avm/source_generators/option_list'
require 'avm/with/application_stereotype'
require 'eac_ruby_utils/core_ext'

module Avm
  module SourceGenerators
    class Base
      acts_as_abstract
      enable_settings_provider
      enable_speaker
      include ::Avm::With::ApplicationStereotype

      class << self
        # @return [Avm::SourceGenerators::OptionList]
        def option_list
          Avm::SourceGenerators::OptionList.new
        end
      end

      OPTION_NAME = 'name'
      JOBS = [].freeze

      common_constructor :target_path, :options, default: [{}] do
        self.target_path = target_path.to_pathname
        self.options = option_list.validate(options)
      end

      # @return [String]
      def name
        options[OPTION_NAME].if_present(target_path.basename.to_path)
      end

      # @return [Avm::SourceGenerators::OptionList]
      def option_list
        self.class.option_list
      end

      def perform
        start_banner
        assert_clear_directory
        apply_template
        perform_jobs
      end

      def assert_clear_directory
        target_path.mkpath
        raise "\"#{target_path}\" is not empty" if target_path.children.any?
      end

      def apply_template
        root_template.apply(self, target_path)
      end

      def perform_jobs
        setting_value(:jobs).each do |job|
          infom "Generating #{job.humanize}..."
          send("generate_#{job}")
        end
      end

      # @return [void]
      def start_banner
        infov 'Target path', target_path
        infov 'Application name', name
      end

      # @return [EacTemlates::Modules::Base]
      def root_template
        template
      end
    end
  end
end
