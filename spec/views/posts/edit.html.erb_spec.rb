require 'rails_helper'

describe 'posts/edit', type: :view do
  let(:post) { FactoryBot.create :post }

  before do
    assign(:post, post)
  end

  it 'renders the edit post form' do
    render

    assert_select 'form[action=?][method=?]', post_path(post), 'post' do
    end
  end
end
