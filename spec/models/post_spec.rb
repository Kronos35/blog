require 'rails_helper'

describe Post do
  context 'with valid attributes' do
    subject(:post) { FactoryBot.build :post }

    before { is_expected.to be_valid }

    it('must belong to a user') { expect(post.user).to be_present }
    it('has a title')           { expect(post.title).to be_present }
    it('has a body')            { expect(post.body).to be_present }
  end

  context 'with blank attributes' do
    subject(:post) { described_class.new }

    before { is_expected.to be_invalid }

    it('has "user must exist" error')       { expect(post.errors[:user]).to include 'must exist' }
    it('has title "can\'t be blank error"') { expect(post.errors[:title]).to include 'can\'t be blank' }
    it('has body "can\'t be blank error"')  { expect(post.errors[:body]).to include 'can\'t be blank' }
  end
end
