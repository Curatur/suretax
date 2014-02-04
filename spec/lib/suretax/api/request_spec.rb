require 'spec_helper'

describe Suretax::Api::Request do

  let(:args) { suretax_valid_request_params }
  let(:api_request) { Suretax::Api::Request.new(args) }
  let(:valid_params) { valid_encoded_test_request_body }

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

  context 'configuration' do
    it 'should use Suretax.configuration by default' do
      req = Suretax::Api::Request.new
      expect(req.client_number).to eql(suretax_client_number)
    end

    it 'should allow the default configuration to be overridden' do
      client_number = '1122334455'

      req = Suretax::Api::Request.new({client_number: client_number})

      expect(req.client_number).to eql(client_number)
    end
  end

  context 'defaults' do
    describe '#client_number' do
      it 'should have :client_number set to the configuration default' do
        req = Suretax::Api::Request.new
        expect(req.client_number).to eql(suretax_client_number)
      end

      it 'should allow you to override the default' do
        client_no = '9911991199'
        req = Suretax::Api::Request.new({ client_number: client_no })
        expect(req.client_number).to eql(client_no)
      end
    end

    describe '#validation_key' do
      it 'should have :validation_key set to the configuration default' do
        req = Suretax::Api::Request.new
        expect(req.validation_key).to eql(suretax_key)
      end

      it 'should allow you to override the default' do
        key = '9911991199-abdce-000000000'
        req = Suretax::Api::Request.new({ validation_key: key })
        expect(req.validation_key).to eql(key)
      end
    end

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

  describe '#params' do
    it 'should return a valid parameters hash' do
      expect(api_request.params).to eql(valid_params)
    end
  end
end

