require 'spec_helper'

describe Suretax do

  let(:config) { Suretax.configuration }

  describe ".configure" do

    let(:key) { 'xxxxxxxx' }
    let(:url) { 'http://test.dev' }
    let(:client) { '9999999999' }
    let(:post_path) { '/Services/V01/SureTax.asmx/PostRequest' }
    let(:cancel_path) { '/Services/V01/SureTax.asmx/CancelPostRequest' }

    before do
      Suretax.configure do |c|
        c.base_url = url
        c.validation_key = key
        c.client_number = client
        c.post_path = post_path
        c.cancel_path = cancel_path
      end
    end

    it 'should allow me to set the validation key' do
      expect(config.validation_key).to include(key)
    end

    it 'should allow me to set the API server base url' do
      expect(config.base_url).to include(url)
    end

    it 'should allow me to set the client number' do
      expect(config.client_number).to include(client)
    end

    it 'should allow me to set the default post path' do
      expect(config.post_path).to include(post_path)
    end

    it 'should allow me to set the default cancel path' do
      expect(config.cancel_path).to include(cancel_path)
    end
  end

  describe 'loading from the app environment' do
    it 'should allow me to set the validation key' do
      expect(suretax_key).to_not match(/\A\s*\z/)
      expect(config.validation_key).to include(suretax_key)
    end

    it 'should allow me to set the API server base url' do
      expect(suretax_url).to_not match(/\A\s*\z/)
      expect(config.base_url).to include(suretax_url)
    end
  end

end
