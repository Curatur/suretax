
require 'spec_helper'

include RequestSpecHelper

describe Suretax::Connection do

  describe '#post' do
    let(:connection) { Suretax::Connection.new }

    let(:body) { valid_encoded_test_request_body }

    let(:response) {
      VCR.use_cassette('successful_post') do
        connection.post(body: body)
      end
    }

    it 'should be successful' do
      expect(response).to be_success
    end

    it 'should return the correct response body' do
      expect(response.body['ResponseCode']).to eql(
        valid_test_response_body['ResponseCode']
      )

      expect(response.body['TotalTax']).to eql(
        valid_test_response_body['TotalTax']
      )
    end

    it 'should have a urlencode header' do
      expect(connection.headers['Content-Type']).to include('application/x-www-form-urlencoded')
    end
  end

end
