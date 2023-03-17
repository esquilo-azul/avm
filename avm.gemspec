# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/version'

Gem::Specification.new do |s|
  s.name        = 'avm'
  s.version     = Avm::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'Ruby base library for Agora Vai! Methodology (https://avm.esquiloazul.tech).'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'aranha-parsers', '~> 0.16'
  s.add_dependency 'eac_cli', '~> 0.30', '>= 0.30.1'
  s.add_dependency 'eac_config', '~> 0.12'
  s.add_dependency 'eac_docker', '~> 0.6'
  s.add_dependency 'eac_fs', '~> 0.16'
  s.add_dependency 'eac_git', '~> 0.14', '>= 0.14.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.112'
  s.add_dependency 'eac_templates', '~> 0.3', '>= 0.3.2'
  s.add_dependency 'filesize', '~> 0.2'
  s.add_dependency 'htmlbeautifier', '~> 1.4', '>= 1.4.2'
  s.add_dependency 'minitar', '~> 0.9'

  s.add_development_dependency 'avm-eac_ruby_base1', '~> 0.24'
  s.add_development_dependency 'avm-git', '~> 0.7'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.5.1'
end
