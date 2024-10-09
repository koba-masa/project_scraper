# frozen_string_literal: true

require 'csv'
require './app/models/web_pages/techcareer_freelance'
require './app/models/web_pages/levtech_freelance'
require './app/models/web_pages/findy_freelance'
require './app/models/web_pages/indeed'

class Main
  ALL_CSV_FILE = './tmp/projects.csv'

  def run
    all_urls = read_all_data

    new_urls = []
    all_urls, individual_new_urls = techfree(all_urls)
    new_urls.concat(individual_new_urls)
    all_urls, individual_new_urls = levetech(all_urls)
    new_urls.concat(individual_new_urls)
    all_urls, individual_new_urls = findy(all_urls)
    new_urls.concat(individual_new_urls)
    # TODO: Blockされる
    # [5] pry(#<WebPages::Indeed>)> @web_driver.title
    # => "Blocked - Indeed.com"
    # all_urls, individual_new_urls = indeed(all_urls)
    # new_urls.concat(individual_new_urls)

    write_all_data(all_urls)
    output_new_urls(new_urls)
  end

  private

  def techfree(all_urls)
    list_url = 'https://freelance.techcareer.jp/projects/occupations/server-side-engineer/?jobs_per_page=30&scope=search&skill=43'
    web_page = WebPages::TechcareerFreelance.new(list_url)
    urls = web_page.get_projects
    new_urls = urls.reject { |url| all_urls.include?(url) }

    all_urls.concat(new_urls)
    [all_urls, new_urls]
  end

  def levetech(all_urls)
    list_url = 'https://freelance.levtech.jp/project/skill-8/'
    web_page = WebPages::LevetechFreelance.new(list_url)
    urls = web_page.get_projects
    new_urls = urls.reject { |url| all_urls.include?(url) }

    all_urls.concat(new_urls)
    [all_urls, new_urls]
  end

  def findy(all_urls)
    list_url = 'https://freelance.findy-code.io/works?page=1&development_language_id=7'
    web_page = WebPages::FindyFreelance.new(list_url)
    urls = web_page.get_projects
    new_urls = urls.reject { |url| all_urls.include?(url) }

    all_urls.concat(new_urls)
    [all_urls, new_urls]
  end

  def indeed(all_urls)
    list_url = 'https://jp.indeed.com/jobs?q=Ruby&l=%E6%9D%B1%E4%BA%AC%E9%83%BD&from=searchOnHP&vjk=926fe91af52796cb&advn=9157842252305269'
    web_page = WebPages::Indeed.new(list_url)
    urls = web_page.get_projects
    new_urls = urls.reject { |url| all_urls.include?(url) }

    all_urls.concat(new_urls)
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
    puts '== Results =========================================='
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
