require 'rails_helper'

describe 'posts/show' do
  let(:user) { create :user }
  let(:post) { create :post, user: user }

  before do
    assign(:post, post)
  end

  it 'renders title' do
    render
    expect(rendered).to have_selector 'h1', text: post.title
  end

  it 'renders body' do
    render
    expect(rendered).to have_selector 'p', text: post.body
  end

  it 'renders user name' do
    render
    expect(rendered).to have_selector 'small', text: user.name
  end
end
