require "thor"
require "apple_system_status"

module AppleSystemStatus
  class CLI < Thor
    desc "fetch", "Fetch apple system status"
    option :country, desc: "country code. (e.g. jp, ca, fr)", default: "us"
    option :title,   desc: "If specified, narrow the service title"
    option :format,  desc: "output format. (e.g. plain, json)", default: "plain"
    def fetch
      response = AppleSystemStatus::Crawler.perform(
        country: options[:country],
        title:   options[:title],
      )
      puts AppleSystemStatus.format_response(response, options[:format])
    end

    desc "version", "Show apple_system_status version"
    def version
      puts AppleSystemStatus::VERSION
    end
  end
end
