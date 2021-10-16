module AppleSystemStatus
  require "capybara"
  require "selenium-webdriver"

  class Crawler
    USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"

    DEFAULT_CHROME_OPTIONS_ARGS = %W(
      headless
      disable-gpu
      window-size=1280,800
      no-sandbox
      user-agent=#{USER_AGENT}
    ).freeze

    MAX_RETRY_COUNT = 5

    # @param chrome_options_args [Array<String>]
    # @param chrome_options_binary [String]
    def initialize(chrome_options_args: DEFAULT_CHROME_OPTIONS_ARGS, chrome_options_binary: nil)
      Capybara.register_driver :chrome_headless do |app|
        client = Selenium::WebDriver::Remote::Http::Default.new
        client.read_timeout = 120

        chrome_options = { args: chrome_options_args }
        chrome_options[:binary] = chrome_options_binary if chrome_options_binary
        chrome_options[:w3c] = false # for chrome 75+

        capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: chrome_options)

        Capybara::Selenium::Driver.new(
          app,
          browser: :chrome,
          capabilities: capabilities,
          http_client: client,
        )
      end
      @session = Capybara::Session.new(:chrome_headless)
    end

    def quit!
      @session.driver.quit if @session
    end

    # crawl apple system status page
    # @param country [String] country code. (e.g. jp, ca, fr. default. us)
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

      response = {
        title:    @session.find(".section-date .date-copy").text.strip,
        services: [],
      }

      MAX_RETRY_COUNT.times do
        services = fetch_services

        if services.empty?
          # wait until the page is fully loaded
          sleep 1
        else
          response[:services] = services
          break
        end
      end

      raise "Not found services" if response[:services].empty?

      unless self.class.blank_string?(title)
        response[:services].select! { |service| service[:title] == title }
      end

      response[:services].sort_by! { |service| service[:title] }

      response
    end

    def apple_url(country)
      if self.class.blank_string?(country) || country == "us"
        "https://www.apple.com/support/systemstatus/"
      else
        "https://www.apple.com/#{country}/support/systemstatus/"
      end
    end

    # crawl apple system status page. When finished crawling, clear capybara session
    # @param country [String] country code. (e.g. jp, ca, fr. default. us)
    # @param title   [String] If specified, narrow the service title
    # @param chrome_options_args [Array<String>]
    # @param chrome_options_binary [String]
    # @return [Hash]
    # @example response format
    #   {
    #     title: ,
    #     services: [
    #       { title: , description: , status:  }
    #     ]
    #   }
    # @link https://github.com/teampoltergeist/poltergeist#memory-leak
    def self.perform(country: nil, title: nil, chrome_options_args: DEFAULT_CHROME_OPTIONS_ARGS, chrome_options_binary: nil)
      crawler = AppleSystemStatus::Crawler.new(chrome_options_args: chrome_options_args, chrome_options_binary: chrome_options_binary)
      crawler.perform(country: country, title: title)
    ensure
      crawler.quit!
    end

    def self.blank_string?(str)
      return true unless str
      str.strip.empty?
    end

    private

    def fetch_services
      @session.all("#ssp-lights-table td").each_with_object([]) do |td, services|
        begin
          names = td.find(".light-container .light-content.light-name").text.split(/[-:]/).map(&:strip)
          light_image = td.find(".light-container .light-content.light-image div")["class"]

          services << {
            title:       names[0],
            description: names[1],
            status:      light_image.gsub("light-", ""),
          }
        rescue Capybara::ElementNotFound
          # suppress error (for blank cell)
          # NOTE: Capybara::Node::Matchers#has_css? is very slow!
        end
      end
    end
  end
end
