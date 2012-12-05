# -*- encoding: utf-8 -*-
require File.expand_path('../lib/douban_api/version', __FILE__)

Gem::Specification.new do |s|
  s.add_runtime_dependency('faraday', ['>= 0.7', '< 0.9'])
  s.add_runtime_dependency('faraday_middleware', '~> 0.8')
  s.add_runtime_dependency('multi_json', '>= 1.0.3', '~> 1.0')
  s.add_runtime_dependency('hashie',  '>= 0.4.0')
  s.add_development_dependency('json', '~> 1.7')
  s.add_development_dependency('rspec', '~> 2.4')
  s.add_development_dependency('webmock', '~> 1.6')
  s.add_development_dependency('bluecloth', '~> 2.0.11')
  s.add_development_dependency('rake')
  s.add_development_dependency('yard')
  s.add_development_dependency('pry')
  s.authors = ["Sean Lee"]
  s.description = %q{A Ruby wrapper for the Douban API v2 based on instagram's official ruby gem}
  s.email = ['iseansay@gmail.com']
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.name = 'douban_api'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if s.respond_to? :required_rubygems_version=
  s.summary = %q{Ruby wrapper for the Douban API v2}
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = Douban::VERSION.dup
end
