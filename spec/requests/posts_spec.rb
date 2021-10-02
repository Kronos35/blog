require 'rails_helper'

describe 'Posts' do
  describe 'GET /index' do
    context 'when the user is signed in' do
      context 'and the user follows another user' do
        it 'searches for the posts of the followed users'
      end

      context 'and the user does not follow anyone but has posts of his own' do
        it 'shows his own posts'
      end

      context 'and the user does not follow anybody' do
        it 'displays no posts at all'
      end
    end

    context 'when no user is signed in' do
      it 'redirects to sign in page'
    end
  end
end
