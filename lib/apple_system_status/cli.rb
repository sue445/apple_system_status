require "thor"
require "apple_system_status"

module AppleSystemStatus
  class CLI < Thor
    desc "fetch", "Fetch apple system status"
    option :country, desc: "country code. (ex. jp, ca, fr)"
    option :format, desc: "output format. (ex. plain, json)", default: "plain"
    def fetch
      response = AppleSystemStatus::Crawler.new.perform(options[:country])
      puts AppleSystemStatus.format_response(response, options[:format])
    end

    desc "version", "Show apple_system_status version"
    def version
      puts AppleSystemStatus::VERSION
    end
  end
end
