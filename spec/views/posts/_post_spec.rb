require 'rails_helper'

describe 'posts/_post.html.slim' do
  let!(:post) { create :post }

  before do
    render partial: 'posts/post.html.slim', locals: { post: post }
  end

  it('displays body')         { expect(rendered).to have_selector('td', text: post.body) }
  it('displays title')        { expect(rendered).to have_selector('td', text: post.title) }
  it('displays show link')    { expect(rendered).to have_selector("a[href='#{post_path(post)}']") }
  it('displays edit link')    { expect(rendered).to have_selector("a[href='#{edit_post_path(post)}']") }
end
