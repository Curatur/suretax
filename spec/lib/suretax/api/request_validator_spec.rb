require 'spec_helper'

describe Suretax::Api::RequestValidator do

  describe '.valid?' do
    let(:result) {
      Suretax::Api::RequestValidator.valid?(request)
    }

    context 'with a valid Request' do
      let(:request) {
        Suretax::Api::Request.new(suretax_valid_request_params)
      }

      it 'should be true' do
        expect(result).to eql(true)
      end
    end

    context 'with an invalid Request' do
      let(:request) {
        Suretax::Api::Request.new()
      }

      it 'should be false' do
        expect(result).to eql(false)
      end
    end

    context 'with invalid items' do
      let(:request) {
        Suretax::Api::Request.new(suretax_valid_request_params)
      }

      before do
        request.items = [ Suretax::Api::RequestItem.new ]
      end

      it 'should be false' do
        expect(result).to eql(false)
      end
    end
  end
end
