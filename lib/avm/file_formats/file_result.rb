# frozen_string_literal: true

require 'avm/file_formats/utf8_assert'
require 'eac_fs/file_info'
require 'ostruct'

module Avm
  module FileFormats
    class FileResult
      common_constructor :file, :format, :changed
    end
  end
end
