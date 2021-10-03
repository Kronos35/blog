require 'rails_helper'

describe User do
  context 'with valid attributes' do
    subject(:user) { create :tony_stark }

    before { user.valid? }

    it('has a name')     { expect(user.name).to be_present }
    it('has an email')   { expect(user.email).to be_present }
    it('has a password') { expect(user.password).to be_present }
  end

  context 'without any attributes' do
    subject(:user) { described_class.new }

    before { user.invalid? }

    it('has "name can\'t be blank" error') { expect(user.errors[:name]).to include 'can\'t be blank' }
    it('has "email can\'t be blank" error') { expect(user.errors[:email]).to include 'can\'t be blank' }
    it('has "password can\'t be blank" error') { expect(user.errors[:password]).to include 'can\'t be blank' }
  end

  context 'with invalid attributes' do
    subject(:user) { build :user, email: 'email', password: 'password1234' }

    before { user.invalid? }

    it 'has email errors' do
      expect(user.errors[:email]).not_to be_empty
    end

    it 'has password errors' do
      expect(user.errors[:password]).not_to be_empty
    end
  end
end

describe User, '#posts' do
  subject(:posts) { user.posts }

  let(:user) { create :user }

  context 'when user has posts' do
    let!(:user_posts) { create_list(:post, 3, user: user) }

    it 'returns an array of posts' do
      expect(posts).to match_array(user_posts)
    end
  end

  context 'when other user has posts' do
    let!(:user_posts) { create_list :post, 3, user: create(:tony_stark) }

    it 'returns an empty array' do
      expect(posts).to be_empty
    end
  end

  context 'when user does not have any posts' do
    it 'returns an empty array' do
      expect(posts).to be_empty
    end
  end
end

describe User, '#follows' do
  subject(:follows) { user.follows }

  let(:user) { create :user }

  context 'when user has follows' do
    let!(:user_follows) { [create(:follow, user: user)] }

    it 'returns an array of follows' do
      expect(follows).to match_array(user_follows)
    end
  end

  context 'when other user has follows' do
    let(:user_follows) { create :follow, user: create(:tony_stark) }

    it 'returns an empty array' do
      expect(follows).to be_empty
    end
  end

  context 'when user does not have any follows' do
    it 'returns an empty array' do
      expect(follows).to be_empty
    end
  end
end

describe User, '#followings' do
  subject(:followings) { user.followings }

  let(:user) { create :tony_stark }

  context 'when user has followings' do
    let!(:user_follows) { [create(:follow, recipient: user)] }

    it 'returns an array of followings' do
      expect(followings).to match_array(user_follows)
    end
  end

  context 'when other user has followings' do
    let(:user_follows) { create :follow, recipient: create(:tony_stark), user: create(:steve_rogers) }

    it 'returns an empty array' do
      expect(followings).to be_empty
    end
  end

  context 'when user does not have any followings' do
    it 'returns an empty array' do
      expect(followings).to be_empty
    end
  end
end

describe User, '#follow!' do
  let(:antonio) { create :antonio }

  context 'when antonio starts following another user' do
    let(:tony_stark) { create :tony_stark }

    it 'creates a follow for antonio' do
      expect { antonio.follow! tony_stark }.to change(antonio.follows, :count).by(1)
    end
  end

  context 'when antonio starts following himself' do
    it 'does not create a new follow' do
      expect { antonio.follow! antonio }.not_to change(antonio.follows, :count).from(0)
    end
  end
end

describe User, '#followers' do
  subject(:followers) { user.followers }

  let(:user) { create :user }

  context 'when user has followers' do
    let(:steve_rogers) { create :steve_rogers }

    before { steve_rogers.follow! user }

    it 'returns an array of followers' do
      expect(followers).to include steve_rogers
    end
  end

  context 'when other user has followers' do
    let(:steve_rogers) { create :steve_rogers }
    let(:tony_stark) { create :tony_stark }

    before { steve_rogers.follow! tony_stark }

    it 'returns an empty array' do
      expect(followers).to be_empty
    end
  end

  context 'when user does not have any followers' do
    it 'returns an empty array' do
      expect(followers).to be_empty
    end
  end
end

describe User, '#followed_users' do
  subject(:followed_users) { user.followed_users }

  let(:user) { create :user }
  let(:steve_rogers) { create :steve_rogers }
  let(:tony_stark) { create :tony_stark }

  context 'when user has followed_users' do
    before do
      user.follow! steve_rogers
      user.follow! tony_stark
    end

    it 'returns an array of followed_users' do
      expect(followed_users).to match_array [steve_rogers, tony_stark]
    end
  end

  context 'when other user has followed_users' do
    before { steve_rogers.follow! tony_stark }

    it 'returns an empty array' do
      expect(followed_users).to be_empty
    end
  end

  context 'when user does not have any followed_users' do
    it 'returns an empty array' do
      expect(followed_users).to be_empty
    end
  end
end

describe User, '#followed_posts' do
  let(:user) { create :user }

  let(:tony_stark) { create :tony_stark }
  let(:steve_rogers) { create :steve_rogers }

  context 'when user follows no one' do
    context 'with posts' do
      let(:expected_posts) { create_list :post, 3, user: user }

      it 'returns posts owned by the user' do
        expect(user.followed_posts).to match_array(expected_posts)
      end
    end

    context 'without any posts' do
      it { expect(user.followed_posts).to be_empty }
    end
  end

  context 'when user follows another user' do
    before { user.follow! tony_stark }

    context 'with posts' do
      let!(:expected_posts) { create_list :post, 3, user: tony_stark }

      it 'returns posts by followed user' do
        expect(user.followed_posts).to match_array expected_posts
      end
    end

    context 'without posts' do
      before { create_list :post, 3, user: steve_rogers }

      it 'returns posts by followed user' do
        expect(user.followed_posts).to be_empty
      end
    end
  end

  context 'when user follows multiple users' do
    before do
      user.follow! tony_stark
      user.follow! steve_rogers
    end

    context 'with posts' do
      let!(:expected_posts) do
        create_list(:post, 3, user: tony_stark) + create_list(:post, 3, user: steve_rogers)
      end

      it 'returns posts by followed user' do
        expect(user.followed_posts).to match_array expected_posts
      end
    end

    context 'without posts' do
      before { create_list :post, 3, user: create(:bruce_banner) }

      it 'returns posts by followed user' do
        expect(user.followed_posts).to be_empty
      end
    end
  end
end
