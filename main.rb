# frozen_string_literal: true

class Main
  def run
    'Hello, World!'
  end
end

if $PROGRAM_NAME == __FILE__
  require 'bundler/setup'
  Bundler.require(:default, ENV['APP_ENV'].to_s)

  Main.new.run
end
