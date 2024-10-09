# frozen_string_literal: true

module SinglePageApplication
  def driver(options = nil, remote_selenium_server_url = nil)
    return @driver unless @driver.nil?

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = ENV.fetch('SELENIUM_READ_TIMEOUT', 180).to_i
    @driver = if remote_selenium_server_url
                Selenium::WebDriver.for(
                  :chrome,
                  capabilities: [options],
                  http_client: client,
                )
              else
                Selenium::WebDriver.for(
                  :remote,
                  url: remote_selenium_server_url,
                  capabilities: [options],
                  http_client: client,
                )
              end
    @driver.manage.timeouts.implicit_wait = 10
    @driver
  end

  def get(web_driver, url)
    web_driver.get(url)
    web_driver
  end

  def close(web_driver)
    web_driver.close
    web_driver.quit
  end
end
