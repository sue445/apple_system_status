source 'https://rubygems.org'

# Specify your gem's dependencies in apple_system_status.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.2")
  # NOTE: rack 2.x supports only ruby 2.2.2+
  gem "rack", "< 2.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.3.0")
  # NOTE: xpath 3.2.0+ requires ruby 2.3.0+
  gem "xpath", "< 3.2.0"

  # NOTE: selenium-webdriver 3.142.1+ requires ruby 2.3.0+
  gem "selenium-webdriver", "< 3.142.1"

  # NOTE: public_suffix v3.1.0+ requires ruby 2.3.0+
  gem "public_suffix", "< 3.1.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.4.0")
  # NOTE: capybara 3.16.0+ requires ruby 2.4.0+
  gem "capybara", "< 3.16.0"
end
