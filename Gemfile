source 'https://rubygems.org'

# Specify your gem's dependencies in apple_system_status.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.2")
  # NOTE: rack 2.x supports only ruby 2.2.2+
  gem "rack", "< 2.0.0"
end
