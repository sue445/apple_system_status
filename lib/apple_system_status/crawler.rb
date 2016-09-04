module AppleSystemStatus
  require "capybara"
  require 'capybara/poltergeist'
  require "active_support/core_ext/object/blank"

  class Crawler
    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"

    def initialize
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, js_errors: false)
      end
      @session = Capybara::Session.new(:poltergeist)
      @session.driver.headers = { "User-Agent" => USER_AGENT }
    end

    def quit!
      @session.driver.quit if @session
    end

    # crawl apple system status page
    # @param country [String] country code. (ex. jp, ca, fr. default. us)
    # @param title   [String] If specified, narrow the service title
    # @return [Hash]
    # @example response format
    #   {
    #     title: ,
    #     services: [
    #       { title: , description: , status:  }
    #     ]
    #   }
    def perform(country: nil, title: nil)
      @session.visit(apple_url(country))

      title_parts = [
        @session.find("#key_date_text").text,
        @session.find("#key_date").text,
        @session.find("#key_date_post").text,
      ]

      response = {
        title:    title_parts.join(" ").strip,
        services: [],
      }

      @session.all("#dashboard td").each_with_object(response[:services]) do |td, services|
        begin
          services << {
            title:       td.find("p[role='text']").text,
            description: td.find("p[role='text']")["aria-label"],
            status:      td.find("span")["class"],
          }
        rescue Capybara::ElementNotFound
          # NOTE: Capybara::Node::Matchers#has_css? is very slow!
        end
      end

      unless title.blank?
        response[:services].select! { |service| service[:title] == title }
      end

      response[:services].sort_by! { |service| service[:title] }

      response
    end

    def apple_url(country)
      if country.blank? || country == "us"
        "https://www.apple.com/support/systemstatus/"
      else
        "https://www.apple.com/#{country}/support/systemstatus/"
      end
    end

    # crawl apple system status page. When finished crawling, clear capybara session
    # @param country [String] country code. (ex. jp, ca, fr. default. us)
    # @param title   [String] If specified, narrow the service title
    # @return [Hash]
    # @example response format
    #   {
    #     title: ,
    #     services: [
    #       { title: , description: , status:  }
    #     ]
    #   }
    # @link https://github.com/teampoltergeist/poltergeist#memory-leak
    def self.perform(country: nil, title: nil)
      crawler = AppleSystemStatus::Crawler.new
      crawler.perform(country: country, title: title)
    ensure
      crawler.quit!
    end
  end
end
