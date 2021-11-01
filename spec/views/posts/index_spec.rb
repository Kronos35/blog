require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  let(:user) { create :user }
  let(:posts) { create_list :post, 3, user: user }

  before do
    assign(:posts, posts)
  end

  it 'renders a list of posts' do
    render template: 'posts/index.html.slim'

    posts.each do |post|
      expect(rendered).to have_selector "#post-#{post.id}"
    end
  end
end
