# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ts3_api/version'

Gem::Specification.new do |spec|
  spec.name          = "ts3_api"
  spec.version       = TS3API::VERSION
  spec.authors       = ["simplay"]
  spec.email         = ["silent.simplay@gmail.com"]

  spec.summary       = "Teamspeak 3 Query API"
  spec.description   = "This Gem wraps the functionality of the Teamspeak 3 Query API"
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  # Runtime developer console that can be used for debugging.
  spec.add_development_dependency "pry", "~> 0.10.4"

  # Adds debug-navigation functionality to pry: step, next, breakpoints ...
  spec.add_development_dependency "pry-byebug", "~> 3.4.2"

  # Print pry debugger output in full color.
  spec.add_development_dependency "awesome_print", "~> 1.7.0"

  # A documentation generation tool
  spec.add_development_dependency "yard", "~> 0.9.9"

  # Code coverage for Ruby
  spec.add_development_dependency "simplecov"

  # Adds around and before_all/after_all/around_all hooks for Minitest
  spec.add_development_dependency "minitest-hooks"

  # A mocking and stubbing library for Ruby
  spec.add_development_dependency "mocha"

  # Style checker
  spec.add_development_dependency "pronto"
  spec.add_development_dependency "pronto-rubocop"

  spec.add_runtime_dependency "dotenv"
end
