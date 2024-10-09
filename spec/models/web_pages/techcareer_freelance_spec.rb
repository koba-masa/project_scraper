# frozen_string_literal: true

require 'spec_helper'

require './app/models/web_pages/techcareer_freelance'

module WebPages
  RSpec.describe TechcareerFreelance do
    let(:test_url) { 'https://freelance.techcareer.jp/projects/occupations/server-side-engineer/?jobs_per_page=30&scope=search&skill=43' }

    describe '#get_projects', :vcr do
      it 'return a list of projects' do
        web_page = described_class.new(test_url)
        projects = web_page.get_projects

        expect(projects.size).not_to eq(0)
      end
    end
  end
end
