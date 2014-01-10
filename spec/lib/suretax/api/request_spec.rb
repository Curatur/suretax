require 'spec_helper'

describe Suretax::Api::Request do

  let(:args) {
    suretax_valid_request_params
  }

  let(:api_request) {
    Suretax::Api::Request.new(args)
  }

  let(:valid_params) {
    valid_encoded_test_request_body
  }

  describe 'accessors' do
    {
       business_unit: "testing",
       client_number: suretax_client_number,
       client_tracking: "track",
       data_month: "7",
       data_year: "2013",
       industry_exemption: "",
       response_group: "03",
       response_type: "D6",
       return_file_code: "0",
       total_revenue: "40",
       validation_key: suretax_key
    }.each_pair do |key,value|

      it "##{key} should return the correct value" do
        api_request.send("#{key.to_s}=",value)
        expect(api_request.send(key)).to eql(value)
      end

    end
  end

  context 'defaults' do
    describe '#return_file_code' do
      it 'should have :return_file_code set to "0"' do
        req = Suretax::Api::Request.new
        expect(req.return_file_code).to eql('0')
      end

      it 'should allow you to override the default' do
        req = Suretax::Api::Request.new({ return_file_code: 'Q' })
        expect(req.return_file_code).to eql('Q')
      end
    end
  end

  describe '#valid?' do
    context 'when the request is valid' do
      it 'should be true' do
        expect(api_request).to be_valid
      end
    end

    context 'when the request is not valid' do
      it 'should be false' do
        api_request.items = nil
        expect(api_request).to_not be_valid
      end
    end
  end

  describe '#params' do
    it 'should return a valid parameters hash' do
      expect(api_request.params).to eql(valid_params)
    end
  end
end

