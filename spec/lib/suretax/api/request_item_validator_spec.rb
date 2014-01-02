require 'spec_helper'

describe Suretax::Api::RequestItemValidator do

  describe '.valid?' do

    let(:result) {
      Suretax::Api::RequestItemValidator.valid?(request_item)
    }

    let(:request_item) {
      Suretax::Api::RequestItem.new(suretax_valid_request_item_params)
    }

    it 'should be true with a valid Request' do
      expect(result).to eql(true)
    end

    describe 'validations' do

      describe '#customer_number' do
        it 'should not be valid when it is not a number' do
          request_item.customer_number = ''
          expect(result).to eql(false)
        end

        it 'should not be valid when the length is wrong' do
          request_item.customer_number = '1'
          expect(result).to eql(false)
        end

        it 'should not be valid when it is not a number' do
          request_item.customer_number = 'aaaaaaaaa'
          expect(result).to eql(false)
        end

        it 'should be valid when it is a nine-digit number' do
          expect(result).to eql(true)
        end
      end

      describe '#invoice_number' do
        it 'should not be valid when it is empty' do
          request_item.invoice_number = ''
          expect(result).to eql(false)
        end

        it 'should not be valid when it is not a number' do
          request_item.invoice_number = 'aaaaaaaaa'
          expect(result).to eql(false)
        end

        it 'should be valid when it is a number' do
          expect(result).to eql(true)
        end
      end
    end
  end
end
