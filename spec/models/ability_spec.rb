require 'rails_helper'

describe Ability do
  context 'when initialized with a user' do
    subject(:ability) { described_class.new(user) }

    let(:user) { create :user }
    let(:resources) { %w[post] }

    it 'merges PostAbility' do
      resources.each do |resource|
        expect("abilities/resources/#{resource}_ability".classify.safe_constantize)
          .to receive(:new).with(user).and_call_original
      end

      described_class.new(user)
    end
  end
end
