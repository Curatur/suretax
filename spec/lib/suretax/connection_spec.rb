require 'spec_helper'

describe Suretax::Connection do

  let(:connection) { Suretax::Connection.new }

  let(:request_body) {
    valid_encoded_test_request_body
  }

  let(:response) {
    connection.post(body: request_body)
  }

  context 'using v01 of the API' do

    describe '#post' do
      it_should_behave_like 'API connection' do
        let(:response_body) {
          suretax_wrap_response(valid_test_response_body.to_json)
        }
      end
    end

  end

  context 'using v03 of the API' do

    describe '#post' do
      it_should_behave_like 'API connection' do
        let(:response_body) {
          suretax_wrap_response(valid_v03_response_body.to_json)
        }
      end
    end

  end
end
