require 'spec_helper' 

describe Suretax::Response do
  let(:api_response_class) {
    Struct.new(:status,:body,:success) do
      def success?
        success
      end
    end
  }

  let(:status_code) { 200 }

  let(:api_response_object) {
    api_response_class.new(
      status_code,
      response_body,
      true
    )
  }

  let(:client_response) {
    Suretax::Response.new(api_response_object)
  }
  context 'when posting is successful' do

    let(:response_body) {
      "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<string xmlns=\"http://tempuri.org/\">{\"Successful\":\"Y\",\"ResponseCode\":\"9999\",\"HeaderMessage\":\"Success\",\"ItemMessages\":[],\"ClientTracking\":\"track\",\"TotalTax\":\"1.394490\",\"TransId\":2668227,\"GroupList\":[{\"StateCode\":\"CA\",\"InvoiceNumber\":\"1\",\"CustomerNumber\":\"000000007\",\"TaxList\":[{\"TaxTypeCode\":\"106\",\"TaxTypeDesc\":\"CA EMERG TEL. USERS SURCHARGE\",\"TaxAmount\":\"0.200760\"},{\"TaxTypeCode\":\"108\",\"TaxTypeDesc\":\"CA P.U.C. FEE\",\"TaxAmount\":\"0.072130\"},{\"TaxTypeCode\":\"109\",\"TaxTypeDesc\":\"CA TELECOM RELAY SYSTEMS SURCHARGE\",\"TaxAmount\":\"0.080000\"},{\"TaxTypeCode\":\"117\",\"TaxTypeDesc\":\"CA HIGH COST FUND(B) SURCHARGE\",\"TaxAmount\":\"0.120000\"},{\"TaxTypeCode\":\"118\",\"TaxTypeDesc\":\"CA TELECONNECT FUND\",\"TaxAmount\":\"0.236000\"},{\"TaxTypeCode\":\"119\",\"TaxTypeDesc\":\"CA HIGH COST FUND(A) SURCHARGE\",\"TaxAmount\":\"0.160000\"},{\"TaxTypeCode\":\"120\",\"TaxTypeDesc\":\"CA ADVANCED SERV FUND SURCH\",\"TaxAmount\":\"0.065600\"},{\"TaxTypeCode\":\"122\",\"TaxTypeDesc\":\"CA UNIVERSAL LIFELINE  SURCHARGE\",\"TaxAmount\":\"0.460000\"}]}]}</string>"
    }

    it 'has a body' do
      expect(client_response.body).to be_instance_of(Hash)
    end

    it 'has a status' do
      expect(client_response.status).to eql(200)
    end

    it "is successful" do
      expect(client_response).to be_success
    end

    it 'has a response object' do
      client_response.response.should respond_to(:status, :body)
    end

    it 'should return the correct response body' do
      expect(client_response.body['ResponseCode']).to eql('9999')
      expect(client_response.body['TotalTax']).to eql('1.394490')
    end
  end

  def suretax_wrap_response(json_string)
        "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<string xmlns=\"http://tempuri.org/\">" + json_string + "</string>"
  end

  context 'when posting is partially successful' do
    let(:response_body) {
      suretax_wrap_response(success_with_item_errors.to_json)
    }

    before do
      api_response_object.success = false
    end

    it 'has a body' do
      expect(client_response.body).to be_instance_of(Hash)
    end

    it 'responds with a 409' do
      expect(client_response.status).to eql(409)
    end

    it "is unsuccessful" do
      expect(client_response).to_not be_success
    end

    it 'has a response object' do
      client_response.response.should respond_to(:status, :body)
    end

    it 'should return the correct response body' do
      expect(client_response.body['ResponseCode']).to eql('9001')
      expect(client_response.body['TotalTax']).to eql('26.53')
    end
  end

  context 'when posting fails' do

    let(:response_body) {
        "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<string xmlns=\"http://tempuri.org/\">{\"Successful\":\"N\",\"ResponseCode\":\"1101\",\"HeaderMessage\":\"Failure - Error parsing request\",\"ItemMessages\":[],\"ClientTracking\":null,\"TotalTax\":null,\"TransId\":2668242,\"GroupList\":[]}</string>"
    }

    before do
      api_response_object.success = false
    end

    it 'has a body' do
      expect(client_response.body).to be_instance_of(Hash)
    end

    it 'responds with a 400' do
      expect(client_response.status).to eql(400)
    end

    it "is unsuccessful" do
      expect(client_response).to_not be_success
    end

    it 'has a response object' do
      client_response.response.should respond_to(:status, :body)
    end

    it 'should return the correct response body' do
      expect(client_response.body['ResponseCode']).to eql('1101')
      expect(client_response.body['TotalTax']).to be_nil
    end
  end
end
