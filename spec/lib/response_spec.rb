require 'spec_helper' 

describe Suretax::Response do
  let(:api_response_class) {
    Struct.new(:status,:body,:success) do
      def success?
        success
      end
    end
  }

  let(:api_response_object) {
    api_response_class.new(
      200,
      failed_post_body,
      true
    )
  }

  let(:failed_post_body) {
      "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<string xmlns=\"http://tempuri.org/\">{\"Successful\":\"N\",\"ResponseCode\":\"1101\",\"HeaderMessage\":\"Failure - Error parsing request\",\"ItemMessages\":[],\"ClientTracking\":null,\"TotalTax\":null,\"TransId\":2668242,\"GroupList\":[]}</string>"
  }

  let(:client_response) {
    Suretax::Response.new(api_response_object)
  }

  it 'has a body' do
    expect(client_response.body).to be_instance_of(Hash)
  end

  it 'has a status' do
    expect(client_response.status).to eql(200)
  end

  it "is successful for a valid response" do
    expect(client_response).to be_success
  end

  it "is unsuccessful for a invalid response" do
    api_response_object.success = false
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
