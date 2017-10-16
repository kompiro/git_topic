# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_topic/version'
def development_dependencies(spec)
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_development_dependency 'rubocop', '~> 0.50.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.17.1'
end

Gem::Specification.new do |spec|
  spec.name          = 'git_topic'
  spec.version       = GitTopic::VERSION
  spec.authors       = ['Hiroki Kondo']
  spec.email         = ['kompiro@gmail.com']

  spec.summary       = 'Manage your topic branches'
  spec.description   = <<'DESC'
  git-topic enables you to manage your topic branches by simple sub commands like "git topic (list/edit/show)".
  This sub commands use branch description.
DESC
  spec.homepage      = 'https://github.com/kompiro/git_topic'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 0.20.0'
  spec.add_runtime_dependency 'term-ansicolor', '~> 1.6.0'
  spec.add_runtime_dependency 'octokit', '~> 4.0'

  development_dependencies(spec)
end
