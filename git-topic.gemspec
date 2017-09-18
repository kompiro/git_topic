lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/topic/version'

Gem::Specification.new do |spec|
  spec.name          = 'git-topic'
  spec.version       = Git::Topic::VERSION
  spec.authors       = ['Hiroki Kondo']
  spec.email         = ['kompiro@gmail.com']

  spec.summary       = 'Manage your topic branches'
  spec.description   = <<'DESC'
  git-topic enables to manage your topic branches by simple sub commands like "git topic (add/list/delete)".
  This sub commands use branch description.
DESC
  spec.homepage      = 'https://github.com/kompiro/git-topic'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.20.0'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_development_dependency 'rubocop', '~> 0.50.0'
end
