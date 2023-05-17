# frozen_string_literal: true

require 'avm/data/performer'
require 'avm/data/rotate'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/temp'

module Avm
  module Data
    class Dumper < ::Avm::Data::Performer
      DEFAULT_EXPIRE_TIME = 1.day

      enable_speaker
      enable_listable
      lists.add_symbol :existing, :denied, :overwrite, :rotate, :rotate_expired
      immutable_accessor :existing, :expire_time, :target_path

      # @return [String, nil]
      def cannot_perform_reason
        return nil if !target_path.exist? ||
                      [EXISTING_OVERWRITE, EXISTING_ROTATE].include?(existing)

        if existing == EXISTING_DENIED
          'Data exist and overwriting is denied'
        elsif existing == EXISTING_ROTATE_EXPIRED && !target_path_expired?
          'Data exist and yet is not expired'
        end
      end

      # @return [Pathname]
      def default_dump_path
        r = data_owner.data_default_dump_path
        include_excludes_path_suffix.if_present(r) do |v|
          r.basename_sub('.*') { |b| "#{b}#{v}#{r.extname}" }
        end
      end

      # @return [Boolean]
      def target_path_expired?
        target_path_time.if_present(false) { |v| v >= expire_time }
      end

      # @return [ActiveSupport::Duration, nil]
      def target_path_time
        target_path.exist? ? ::Time.now - ::File.mtime(target_path) : nil
      end

      protected

      attr_reader :temp_data_path

      # @return [Array<Symbol>]
      def all_units
        data_owner.units.keys.sort
      end

      def build_temp_data_file
        data_owner.dump(temp_data_path, *include_excludes_arguments)
        raise "\"#{temp_data_path}\" do not exist" unless temp_data_path.exist?
        raise "\"#{temp_data_path}\" is not a file" unless temp_data_path.file?
      end

      # @return [Array<Symbol>]
      def excluded_units
        excludes.map(&:to_sym).sort
      end

      # @return [Symbol, nil]
      def existing_set_filter(value)
        value.nil? ? nil : self.class.lists.existing.value_validate!(value)
      end

      # @return [ActiveSupport::Duration]
      def expire_time_get_filter(value)
        value || DEFAULT_EXPIRE_TIME
      end

      # @return [String]
      def include_excludes_path_suffix
        return nil unless data_owner.respond_to?(:units)

        r = included_units.any? ? included_units : all_units
        r -= excluded_units if excluded_units.any?
        r.any? && r != all_units ? "_#{r.join('-')}" : ''
      end

      # @return [Array<Symbol>]
      def included_units
        includes.map(&:to_sym).sort
      end

      # @return [self]
      def internal_perform
        on_temp_data_file do
          build_temp_data_file
          rotate
          move_data_to_target_path
        end
      end

      def move_data_to_target_path
        ::FileUtils.mv(temp_data_path, target_path.assert_parent)
      end

      def on_temp_data_file
        ::EacRubyUtils::Fs::Temp.on_file do |file|
          @temp_data_path = file.to_pathname
          yield
        end
      end

      # @return [String, nil]
      def rotate
        return unless target_path.exist?
        return unless existing == EXISTING_ROTATE

        infom "Rotating \"#{target_path}\"..."
        ::Avm::Data::Rotate.new(target_path).run
      end

      # @return [Pathname]
      def target_path_get_filter(value)
        (value || default_dump_path).to_pathname
      end
    end
  end
end
