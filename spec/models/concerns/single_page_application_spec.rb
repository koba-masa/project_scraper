# frozen_string_literal: true

require 'spec_helper'

require 'open-uri'

require './app/models/concerns/single_page_application'

RSpec.describe SinglePageApplication, type: :selenium do
  let(:klass) do
    Class.new { include SinglePageApplication }
  end
  let(:test_url) { 'https://example.com/' }
  let(:remote_selenium_server_url) { 'http://selenium_server:4444' }

  describe '#get' do
    let(:client) do
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.read_timeout = 180
    end
    let(:options) do
      options = Selenium::WebDriver::Options.chrome
      options.add_argument('--headless')
      options
    end
    let(:driver) do
      web_dirver = Selenium::WebDriver.for(
        :remote,
        url: remote_selenium_server_url,
        options:,
      )
      web_dirver.manage.timeouts.implicit_wait = 10
      web_dirver
    end

    after do
      driver.close
      driver.quit
    end

    it 'returns a driver', :vcr do
      instance = klass.new
      result = instance.get(driver, test_url)

      expect(result.title).to eq('Example Domain')
    end
  end
end
