# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apple_system_status/version'

Gem::Specification.new do |spec|
  spec.name          = "apple_system_status"
  spec.version       = AppleSystemStatus::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = %q{Apple System Status scraping library}
  spec.description   = %q{Apple System Status scraping library}
  spec.homepage      = "https://github.com/sue445/apple_system_status"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.2"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara"
  spec.add_dependency "selenium-webdriver", "< 4.0.0"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "simplecov", "< 0.18.0"
  spec.add_development_dependency "unparser", ">= 0.4.5"
  spec.add_development_dependency "yard"
end
