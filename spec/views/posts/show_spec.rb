require 'rails_helper'

describe 'posts/show' do
  let(:post) { create :post }

  before do
    assign(:post, post)
  end

  it 'renders attributes in' do
    render
  end
end
