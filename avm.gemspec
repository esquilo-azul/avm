# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/version'

Gem::Specification.new do |s|
  s.name        = 'avm'
  s.version     = Avm::VERSION
  s.authors     = ['Eduardo H. Bogoni']
  s.summary     = 'Ruby base library for Agora Vai! Methodology (https://avm.esquiloazul.tech).'

  s.files = Dir.glob('{lib,locale,template}/**/*', File::FNM_DOTMATCH)
              .reject { |f| ['.', '..'].include?(File.basename(f)) }
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'eac_cli', '~> 0.46'
  s.add_dependency 'eac_config', '~> 0.15'
  s.add_dependency 'eac_docker', '~> 0.8'
  s.add_dependency 'eac_fs', '~> 0.20', '>= 0.20.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.130'
  s.add_dependency 'eac_templates', '~> 0.8', '>= 0.8.3'
  s.add_dependency 'minitar', '~> 0.12', '>= 0.12.1'

  s.add_development_dependency 'avm-eac_ruby_base1', '~> 0.40'
  s.add_development_dependency 'avm-git', '~> 0.21', '>= 0.21.2'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.12', '>= 0.12.2'
end
