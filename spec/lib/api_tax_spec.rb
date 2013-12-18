require 'spec_helper'

describe Suretax::Api::Tax do

  let(:tax) { Suretax::Api::Tax.new(tax_params) }

  let(:tax_params) { valid_test_response_body['GroupList'].first['TaxList'].first }

  it 'should have a code' do
    expect(tax.code).to eql('106')
  end

  it 'should have a description' do
    expect(tax.description).to eql('CA EMERG TEL. USERS SURCHARGE')
  end

  it 'should have an amount' do
    expect(tax.amount.to_f).to eql(0.200760)
  end
end
