# frozen_string_literal: true

require './app/models/concerns/single_page_application'
require './app/models/web_page'

module WebPages
  class TechcareerFreelance < WebPage
    include SinglePageApplication

    def initialize(url)
      super

      @options = Selenium::WebDriver::Options.chrome
      @options.add_argument('--headless')
      @web_driver = driver(@options, 'http://selenium_server:4444')
    end

    def get_projects
      @web_driver = get(@web_driver, @url)

      projects = @web_driver.find_elements(:css, 'button.view-detail-btn a').map do |element|
        element.attribute('href')
      end

      close(@web_driver)
      projects
    end

    private

    def options
      return @options unless @options.nil?

      @options = Selenium::WebDriver::Options.chrome
      @options.add_argument('--headless')
    end
  end
end
