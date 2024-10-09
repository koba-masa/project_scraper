# frozen_string_literal: true

class WebPage
  def initialize(url)
    @url = url
    @sleep_time = ENV.fetch('SLEEP_TIME', 10).to_i
  end

  def user_agent
    raise ImplementationError, 'You must implement the get method'
  end

  def get
    raise ImplementationError, 'You must implement the get method'
  end

  def parse
    raise ImplementationError, 'You must implement the parse method'
  end

  def title
    raise ImplementationError, 'You must implement the title method'
  end

  def sleep(sleep_time = @sleep_time)
    sleep sleep_time
  end
end
