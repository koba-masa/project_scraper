# frozen_string_literal: true

require 'csv'
require './app/models/web_pages/techcareer_freelance'

class Main
  ALL_CSV_FILE = './tmp/projects.csv'

  def run
    all_urls = read_all_data

    new_urls = []
    all_urls, techfree_new_urls = techfree(all_urls)
    new_urls.concat(techfree_new_urls)

    write_all_data(all_urls)
    output_new_urls(new_urls)
  end

  private

  def techfree(all_urls)
    url = 'https://freelance.techcareer.jp/projects/occupations/server-side-engineer/?jobs_per_page=30&scope=search&skill=43'
    web_page = WebPages::TechcareerFreelance.new(url)
    urls = web_page.get_projects
    new_urls = urls.select { |url| !all_urls.include?(url) }


    all_urls = all_urls.concat(new_urls)
    [all_urls, new_urls]
  end

  def read_all_data
    urls = []

    return urls unless File.exist?(ALL_CSV_FILE)

    CSV.foreach(ALL_CSV_FILE, headers: true) do |row|
      urls << row['url']
    end
    urls
  end

  def write_all_data(urls)
    CSV.open(ALL_CSV_FILE, 'w') do |csv|
      csv << %w[url]

      urls.each do |url|
        csv << [url]
      end
    end
  end

  def output_new_urls(new_urls)
    puts "== Results =========================================="
    new_urls.each do |url|
      puts url
    end
  end
end

if $PROGRAM_NAME == __FILE__
  require 'bundler/setup'
  Bundler.require(:default, ENV['APP_ENV'].to_s)

  Main.new.run
end
