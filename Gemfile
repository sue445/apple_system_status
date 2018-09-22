source 'https://rubygems.org'

# Specify your gem's dependencies in apple_system_status.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.2")
  # NOTE: rack 2.x supports only ruby 2.2.2+
  gem "rack", "< 2.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.0")
  group :development do
    # NOTE: byebug 9.1.0+ requires ruby 2.2.0+
    gem "byebug", "< 9.1.0", group: :test
  end

  # NOTE: xpath v3+ requires ruby 2.2+
  gem "xpath", "< 3.0.0"
end
