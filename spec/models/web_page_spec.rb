# frozen_string_literal: true

require 'spec_helper'

require './app/models/web_page'

RSpec.describe WebPage do
  describe '#initialize' do
    it 'create a new instance of WebPage' do
      web_page = described_class.new('https://example.com')

      expect(web_page).to be_a(described_class)
    end
  end
end
