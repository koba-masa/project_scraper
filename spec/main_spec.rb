# frozen_string_literal: true

require 'spec_helper'

require './main'

RSpec.describe Main do
  describe 'run', :vcr do
    let(:instance) { described_class.new }

    it do
      expect(instance.run).to eq('Hello, World!')
    end
  end
end
