# frozen_string_literal: true

require 'avm'
EacRubyUtils::Rspec.default_setup_create(File.expand_path('..', __dir__)).stub_avm_contexts
EacRubyUtils.require_sub(__FILE__)
