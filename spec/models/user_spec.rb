require 'rails_helper'

describe User do
  context 'with valid attributes' do
    subject(:user) { FactoryBot.create :user }

    before { is_expected.to be_valid }

    it('has a name')     { expect(user.name).to be_present }
    it('has an email')   { expect(user.email).to be_present }
    it('has a password') { expect(user.password).to be_present }
  end

  context 'without any attributes' do
    subject(:user) { described_class.new }

    before { is_expected.to be_invalid }

    it('has "name can\'t be blank" error')     { expect(user.errors[:name]).to include 'can\'t be blank' }
    it('has "email can\'t be blank" error')    { expect(user.errors[:email]).to include 'can\'t be blank' }
    it('has "password can\'t be blank" error') { expect(user.errors[:password]).to include 'can\'t be blank' }
  end
end