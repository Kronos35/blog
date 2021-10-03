require 'rails_helper'

describe Follow do
  let(:antonio)    { create :antonio }
  let(:tony_stark) { create :tony_stark }

  context 'with valid attributes' do
    subject(:follow) { build :follow, user: antonio, recipient: tony_stark }

    it('is valid')               { expect(follow).to be_valid }
    it('belongs to a user')      { expect(follow.user).to eq antonio }
    it('belongs to a recipient') { expect(follow.recipient).to eq tony_stark }
  end

  context 'with empty attributes' do
    subject(:follow) { described_class.new }

    before { follow.invalid? }

    it('is invalid')                     { expect(follow).to be_invalid }
    it('has user must exist error')      { expect(follow.errors[:user]).to include 'must exist' }
    it('has recipient must exist error') { expect(follow.errors[:recipient]).to include 'must exist' }
  end

  context 'with repeated follows' do
    subject(:follow) { build :follow, user: antonio, recipient: tony_stark }

    before do
      create :follow, user: antonio, recipient: tony_stark
      follow.valid?
    end

    it('is invalid') { expect(follow).to be_invalid }
    it('is has "can\'t be followed twice" error') { expect(follow.errors[:user]).to include('can\'t be followed twice') }
  end
end
