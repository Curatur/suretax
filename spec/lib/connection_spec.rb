require 'spec_helper'

describe Suretax::Connection do

  describe '#post' do
    let(:connection) { Suretax::Connection.new }

    let(:response_body) { 
      '<?xml version="1.0" encoding="utf-8"?>\r\n<string xmlns="http://tempuri.org/">{"Successful":"Y","ResponseCode":"9999","HeaderMessage":"Success"}</string>' 
    }

    let(:request_body) {
      valid_encoded_test_request_body
    }

    let(:response) {
      connection.post(body: request_body)
    }

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

end
