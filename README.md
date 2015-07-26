# AppleSystemStatus

[Apple System Status](https://www.apple.com/support/systemstatus/) scraping library

[![Build Status](https://travis-ci.org/sue445/apple_system_status.svg?branch=master)](https://travis-ci.org/sue445/apple_system_status)
[![Code Climate](https://codeclimate.com/github/sue445/apple_system_status/badges/gpa.svg)](https://codeclimate.com/github/sue445/apple_system_status)
[![Test Coverage](https://codeclimate.com/github/sue445/apple_system_status/badges/coverage.svg)](https://codeclimate.com/github/sue445/apple_system_status/coverage)
[![Coverage Status](https://coveralls.io/repos/sue445/apple_system_status/badge.svg?branch=master&service=github)](https://coveralls.io/github/sue445/apple_system_status?branch=master)
[![Dependency Status](https://gemnasium.com/sue445/apple_system_status.svg)](https://gemnasium.com/sue445/apple_system_status)

## Requirements
* Ruby 2.0+
* [Phantomjs](http://phantomjs.org/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apple_system_status'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apple_system_status

## Usage (via. ruby)
```ruby
crawler = AppleSystemStatus::Crawler.new

# English
pp crawler.perform

{:title=>"System Status as of 12:51 AM JST",
 :services=>
  [{:title=>"App Store",
    :description=>"No Issues: App Store",
    :status=>"allgood"},
   {:title=>"iCloud Account & Sign In",
    :description=>"No Issues: iCloud Account & Sign In",
    :status=>"allgood"},
   # ...
]}

# Japanese
pp crawler.perform("jp")

{:title=>"00:53 JST 時点のシステム状況",
 :services=>
  [{:title=>"App Store", :description=>"問題なし: App Store", :status=>"allgood"},
   {:title=>"iCloud ストレージアップグレード",
    :description=>"問題なし: iCloud ストレージアップグレード",
    :status=>"allgood"},
   {:title=>"iTunes Store",
    :description=>"問題なし: iTunes Store",
    :status=>"allgood"},
   # ...
]}
```

## Usage (via. shell)
```sh
$ apple_system_status help
Commands:
  apple_system_status fetch           # Fetch apple system status
  apple_system_status help [COMMAND]  # Describe available commands or one specific command
  apple_system_status version         # Show apple_system_status version

$ apple_system_status help fetch
Usage:
  apple_system_status fetch

Options:
  [--country=COUNTRY]  # country code. (ex. jp, ca, fr. default. us)
  [--format=FORMAT]    # output format. (ex. plain, json)
                       # Default: plain
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec apple_system_status` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/apple_system_status.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

