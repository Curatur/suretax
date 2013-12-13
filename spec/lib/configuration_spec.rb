require 'spec_helper'

describe Suretax do

  let(:config) { Suretax.configuration }

  describe ".configure" do

    let(:key) { 'xxxxxxxx' }
    let(:url) { 'http://test.dev' }

    before do
      Suretax.configure do |c|
        c.base_url = url
        c.validation_key = key
      end
    end

    it 'should allow me to set the validation key' do
      expect(config.validation_key).to include(key)
    end

    it 'should allow me to set the API server base url' do
      expect(config.base_url).to include(url)
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
