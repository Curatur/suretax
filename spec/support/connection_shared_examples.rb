require 'spec_helper'

shared_examples_for 'API connection' do
  before do
    stub_request(:post, "#{suretax_url}#{suretax_post_path}").to_return(
      status: 200,
      body: response_body
    )
  end

  it 'should be successful' do
    expect(response).to be_success
  end

  it 'should have a urlencode header' do
    expect(connection.headers['Content-Type']).to include('application/x-www-form-urlencoded')
  end
end

