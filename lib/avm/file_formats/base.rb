# frozen_string_literal: true

require 'eac_fs/file_info'
require 'ostruct'

module Avm
  module FileFormats
    class Base
      enable_abstract_methods
      compare_by :class

      # @params files [Enumerable<Pathname>]
      # @return [Enumerable<Avm::FileFormats::FileResult>]
      def apply(_files)
        raise_abstract_method __method__
      end

      # @param path [Pathname]
      # @return [Avm::FileFormats::FileWith]
      def file_resource_name(path)
        path.to_pathname.to_path
      end

      def name
        self.class.name.demodulize
      end

      def match?(file)
        match_by_filename?(file) || match_by_type?(file)
      end

      def valid_basenames
        constant_or_array('VALID_BASENAMES')
      end

      def valid_types
        constant_or_array('VALID_TYPES')
      end

      private

      def constant_or_array(name)
        return [] unless self.class.const_defined?(name)

        self.class.const_get(name)
      end

      def match_by_filename?(file)
        valid_basenames.any? do |valid_basename|
          file.basename.fnmatch?(valid_basename)
        end
      end

      def match_by_type?(file)
        info = ::EacFs::FileInfo.new(file)
        return unless info.content_type.type == 'text'

        valid_types.include?(info.content_type.subtype)
      end
    end
  end
end
