require 'spec_helper'

describe Suretax::Api::RequestItemValidator do

  let(:result) {
    Suretax::Api::RequestItemValidator.valid?(request_item)
  }

  let(:request_item) {
    Suretax::Api::RequestItem.new(suretax_valid_request_item_params)
  }

  describe '.valid?' do

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
          request_item.customer_number = '1' * 11
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
        %w/123 a1234 abcdef/.each do |value|
          it "can be '#{value}'" do
            request_item.invoice_number = value
            expect(result).to eql(true)
          end
        end

        it 'cannot be longer than 20 characters' do
          request_item.invoice_number = '1' * 21
          expect(result).to eql(false)
        end

        it 'can be blank' do
          request_item.invoice_number = nil
          expect(result).to eql(true)
        end
      end

      describe '#line_number' do
        it 'must not be more than 20 characters in length' do
          request_item.line_number = '1' * 21
          expect(result).to eql(false)
        end

        it 'can be blank' do
          request_item.line_number = nil
          expect(result).to eql(true)
        end

        %w/1 40 580 12345678901234567890/.each do |number|
          it "can be '#{number}'" do
            request_item.line_number = number
            expect(result).to eql(true)
          end
        end

        %w/a D0 S10 _/.each do |bad_content|
          it "cannot be '#{bad_content}'" do
            request_item.line_number = bad_content
            expect(result).to eql(false)
          end
        end
      end

      context 'phone number fields' do
        %w/orig_number term_number bill_to_number/.each do |phone_method|

          describe "##{phone_method}" do
            it_should_behave_like 'optional phone number' do
              let(:subject) { phone_method }
            end
          end

        end
      end

      describe '#tax_situs_rule' do
        it 'must be present' do
          request_item.tax_situs_rule = nil
          expect(result).to eql(false)
        end

        %w/01 02 03 04 05 06 07 14/.each do |number|
          it "can be '#{number}'" do
            request_item.tax_situs_rule = number
            expect(result).to eql(true)
          end
        end

        %w/a D0 S10 _/.each do |bad_content|
          it "cannot be '#{bad_content}'" do
            request_item.tax_situs_rule = bad_content
            expect(result).to eql(false)
          end
        end
      end

      describe '#trans_type_code' do
        context 'when present' do
          it 'should pass validation' do
            request_item.trans_type_code = '1'
            expect(result).to eql(true)
          end
        end

        context 'when absent' do
          it 'should fail validation' do
            request_item.trans_type_code = nil
            expect(result).to eql(false)
          end
        end
      end

      describe '#sales_type_code' do
        context 'when present' do
          it 'should allow valid codes' do
            %w/R B I L/.each do |code|
              request_item.sales_type_code = code
              expect(result).to eql(true)
            end
          end

          it 'should not allow invalid codes' do
            %w/A X Y Z/.each do |code|
              request_item.sales_type_code = code
              expect(result).to eql(false)
            end
          end
        end

        context 'when absent' do
          it 'should fail validation' do
            request_item.sales_type_code = nil
            expect(result).to eql(false)
          end
        end
      end

      describe '#regulatory_code' do
        context 'when present' do
          it 'should allow valid codes' do
            %w/00 01 02 03 04 05 99/.each do |code|
              request_item.regulatory_code = code
              expect(result).to eql(true)
            end
          end

          it 'should not allow invalid codes' do
            %w/44 77 4 f -/.each do |code|
              request_item.regulatory_code = code
              expect(result).to eql(false)
            end
          end
        end

        context 'when absent' do
          it 'should fail validation' do
            request_item.regulatory_code = nil
            expect(result).to eql(false)
          end
        end
      end

      describe '#tax_exemption_codes' do
        context 'when present' do
          context 'and the list has content' do
            it 'should pass validation' do
              request_item.tax_exemption_codes = ['00']
              expect(result).to eql(true)
            end
          end

          context 'and the list is empty' do
            it 'should fail validation' do
              request_item.tax_exemption_codes = []
              expect(result).to eql(false)
            end
          end
        end

        context 'when absent' do
          it 'should fail validation' do
            request_item.tax_exemption_codes = nil
            expect(result).to eql(false)
          end
        end
      end
    end
  end
end
