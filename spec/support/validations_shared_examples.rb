require 'spec_helper'

shared_examples_for 'optional phone number' do
  it 'can be blank' do
    request_item.send("#{subject}=",nil)
    expect(result).to eql(true)
  end

  it 'must be numeric' do
    request_item.send("#{subject}=",'abcdefghij')
    expect(result).to eql(false)
  end

  it 'must ten digits' do
    request_item.send("#{subject}=",'1' * 11)
    expect(result).to eql(false)
    request_item.send("#{subject}=",'1' * 9)
    expect(result).to eql(false)
  end
end
