require 'spec_helper'

describe Suretax::Api::Response do

  let(:api_response) { Suretax::Api::Response.new(response_body) }

  context 'with a successful response' do

    let(:response_body) { valid_test_response_body }

    it 'should return the API status code' do
      expect(api_response.status).to eql('9999')
    end

    it 'should be successful' do
      expect(api_response.success?).to be_true
    end

    it 'should have a message of "Success"' do
      expect(api_response.message).to eql('Success')
    end

    it 'should have the correct total tax' do
      expect(api_response.total_tax.to_f).to eql(1.394490)
    end

    context 'invoice groups' do
      it 'should be the correct number' do
        expect(api_response.groups.count).to eql(1)
      end

      it 'should respond to #invoice' do
        expect(api_response.groups.first).to respond_to(:invoice)
      end
    end
  end

  context 'with a partially successful response' do

    let(:response_body) { success_with_item_errors }

    describe '#status' do
      it 'should return the API status code' do
        expect(api_response.status).to eql('9001')
      end
    end

    describe '#success?' do
      it 'should be true' do
        expect(api_response.success?).to be_true
      end
    end

    describe '#message' do
      it 'should start with "Failure"' do
        expect(api_response.message).to match(/\ASuccess with item errors/i)
      end
    end
  end

  context 'with a failure response' do

    let(:response_body) { valid_failure_response }

    describe '#status' do
      it 'should return the API status code' do
        expect(api_response.status).to eql('1101')
      end
    end

    describe '#success?' do
      it 'should be false' do
        expect(api_response.success?).to be_false
      end
    end

    describe '#message' do
      it 'should start with "Failure"' do
        expect(api_response.message).to match(/\AFailure/)
      end
    end
  end
end
