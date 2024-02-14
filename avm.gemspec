# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/version'

Gem::Specification.new do |s|
  s.name        = 'avm'
  s.version     = Avm::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'Ruby base library for Agora Vai! Methodology (https://avm.esquiloazul.tech).'

  s.files = Dir['{lib, locale}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'aranha-parsers', '~> 0.22'
  s.add_dependency 'eac_cli', '~> 0.40'
  s.add_dependency 'eac_config', '~> 0.14', '>= 0.14.1'
  s.add_dependency 'eac_docker', '~> 0.7'
  s.add_dependency 'eac_fs', '~> 0.17'
  s.add_dependency 'eac_git', '~> 0.14', '>= 0.14.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.121'
  s.add_dependency 'eac_templates', '~> 0.5', '>= 0.5.1'
  s.add_dependency 'filesize', '~> 0.2'
  s.add_dependency 'htmlbeautifier', '~> 1.4', '>= 1.4.3'
  s.add_dependency 'minitar', '~> 0.9'

  s.add_development_dependency 'avm-eac_ruby_base1', '~> 0.33'
  s.add_development_dependency 'avm-git', '~> 0.14'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.9'
end
