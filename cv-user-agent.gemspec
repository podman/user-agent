$:.push File.expand_path('../lib', __FILE__)
require 'user-agent/version'

Gem::Specification.new do |s|

  s.name = 'podman-user-agent'
  s.version = UserAgent::VERSION
  s.authors = ['Adam Podolnick']
  s.email = 'podman@gmail.com'
  s.homepage = 'http://github.com/podman/user-agent'
  s.summary = 'User agent parser'
  s.description = 'user-agent is a user agent parser support most of the commonly used browsers today.'
  s.rubyforge_project = 'podman-user-agent'
  s.require_paths = ['lib']

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

end
