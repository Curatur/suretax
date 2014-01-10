require 'spec_helper'

describe Suretax::Api::RequestValidator do

  describe '.valid?' do

    def validation
      Suretax::Api::RequestValidator.valid?(request)
    end

    context 'with a valid Request' do
      let(:request) {
        Suretax::Api::Request.new(suretax_valid_request_params)
      }

      it 'should be true' do
        expect(validation).to eql(true)
      end
    end

    context 'with an empty Request' do
      let(:request) {
        Suretax::Api::Request.new()
      }

      it 'should be false' do
        expect(validation).to eql(false)
      end
    end

    context 'validations' do
        let(:request) {
          Suretax::Api::Request.new(suretax_valid_request_params)
        }

        describe '#client_number' do
          context 'when present' do
            it 'can be ten characters or less' do
              request.client_number = '1234567890'
              expect(validation).to eql(true)
              request.client_number = '12345678901'
              expect(validation).to eql(false)
            end

            it 'must be a number' do
              request.client_number = '1'
              expect(validation).to eql(true)
              request.client_number = 'abcdefghij'
              expect(validation).to eql(false)
            end
          end

          context 'when absent' do
            it 'should fail validation' do
              request.client_number = nil
              expect(validation).to eql(false)
            end
          end
        end

        describe '#business_unit' do
          context 'when present' do
            it 'can be blank' do
              request.business_unit = nil
              expect(validation).to eql(true)
              request.business_unit = ''
              expect(validation).to eql(true)
            end

            it 'can be 20 characters or less' do
              request.business_unit = 'a' * 5
              expect(validation).to eql(true)
              request.business_unit = 'a' * 20
              expect(validation).to eql(true)
              request.business_unit = 'a' * 21
              expect(validation).to eql(false)
            end

            it 'must be alphanumeric' do
              request.business_unit = 'aa124'
              expect(validation).to eql(true)
              request.business_unit = 'a_34'
              expect(validation).to eql(false)
            end
          end

          context 'when absent' do
            it 'should pass validation' do
              request.business_unit = nil
              expect(validation).to eql(true)
            end
          end
        end

        describe '#validation_key' do
          context 'when present' do
            it 'must be a maximum of 36 characters' do
              request.validation_key = 'a' * 36
              expect(validation).to eql(true)
              request.validation_key = 'a' * 37
              expect(validation).to eql(false)
            end
          end

          context 'when absent' do
            it 'should fail validation' do
              request.validation_key = nil
              expect(validation).to eql(false)
            end
          end
        end

        describe '#data_year' do
          context 'when present' do
            it 'must be a number' do
              request.data_year = 'b' * 4
              expect(validation).to eql(false)
              request.data_year = '-' * 4
              expect(validation).to eql(false)
              request.data_year = '2014'
              expect(validation).to eql(true)
            end

            it 'must be exactly four digits' do
              request.data_year = '2014'
              expect(validation).to eql(true)
              request.data_year = '20120'
              expect(validation).to eql(false)
              request.data_year = '201'
              expect(validation).to eql(false)
            end

            it 'must be in the range 1990-2050' do
              request.data_year = '1989'
              expect(validation).to eql(false)
              request.data_year = '2051'
              expect(validation).to eql(false)
            end
          end

          context 'when absent' do
            it 'fails validation' do
              request.data_year = nil
              expect(validation).to eql(false)
            end
          end
        end

        describe '#data_month' do
          context 'when present' do
            it "must allow all valid month numbers" do
              (1..12).each do |month_number|
                request.data_month = month_number.to_s
                expect(validation).to eql(true)
                request.data_month = "%02d" % month_number.to_s
                expect(validation).to eql(true)
              end
            end

            it "must allow all valid month numbers with a preceding zero" do
              (1..12).each do |month_number|
                request.data_month = "%02d" % month_number.to_s
                expect(validation).to eql(true)
              end
            end

            it 'must not allow invalid months' do
              request.data_month = '13'
              expect(validation).to eql(false)
            end
          end

          context 'when absent' do
            it 'should fail validation' do
              request.data_month = nil
              expect(validation).to eql(false)
            end
          end
        end

        describe '#total_revenue' do
          context 'when present' do
            it 'can only be digits and the minus symbol' do
              request.total_revenue = 'abcdefghi.jklm'
              expect(validation).to eql(false)
              request.total_revenue = '+1234'
              expect(validation).to eql(false)
            end

            it 'can have up to four decimal places' do
              request.total_revenue = '123456789.1234'
              expect(validation).to eql(true)
              request.total_revenue = '123456789.1'
              expect(validation).to eql(true)
            end

            it 'must not have more than four decimal places' do
              request.total_revenue = '123456789.12345'
              expect(validation).to eql(false)
            end

            context 'and when the value is positive' do
              it 'should have no symbol' do
                request.total_revenue = '+23456789.1234'
                expect(validation).to eql(false)
              end

              it 'can have up to nine positions to the left of the decimal' do
                request.total_revenue = '123456789.1234'
                expect(validation).to eql(true)
                request.total_revenue = '1.1234'
                expect(validation).to eql(true)
                request.total_revenue = '1234567890.1234'
                expect(validation).to eql(false)
              end

              it 'can be a simple integer' do
                request.total_revenue = '1'
                expect(validation).to eql(true)
              end

            end

            context 'and when the value is negative' do
              it 'should have a "minus" symbol in the first position' do
                request.total_revenue = '-23456789.1234'
                expect(validation).to eql(true)
              end

              it 'must have nine positions to the left of the decimal' do
                request.total_revenue = '-23456789.1234'
                expect(validation).to eql(true)
              end

              it 'must not have more than nine positions to the left of the decimal' do
                request.total_revenue = '-234567890.1234'
                expect(validation).to eql(false)
              end
            end
          end

          context 'when absent' do
            it 'should fail validation' do
              request.total_revenue = nil
              expect(validation).to eql(false)
            end
          end
        end

        describe '#client_tracking' do
          context 'when present' do
            it 'must not be longer than 100 characters' do
              request.client_tracking = 'a' * 101
              expect(validation).to eql(false)
            end
          end

          context 'when absent' do
            it 'should pass validation' do
              request.client_tracking = nil
              expect(validation).to eql(true)
            end
          end
        end

        describe '#return_file_code' do
          context 'when present' do
            it 'must be a valid code' do
              request.return_file_code = 0
              expect(validation).to eql(true)
              request.return_file_code = 'Q'
              expect(validation).to eql(true)
            end

            it 'cannot be any other value' do
              request.return_file_code = 'a'
              expect(validation).to eql(false)
              request.return_file_code = 1
              expect(validation).to eql(false)
              request.return_file_code = '_'
              expect(validation).to eql(false)
            end
          end

          context 'when absent' do
            it 'should fail validation' do
              request.return_file_code = nil
              expect(validation).to eql(false)
            end
          end
        end

        describe '#response_group' do
          context 'when present' do
            it "must be a valid code" do
              %w/00 01 02 03/.each do |code|
                request.response_group = code
                expect(validation).to eql(true)
              end

              %w/a 04 _/.each do |wrong_value|
                request.response_group = wrong_value
                expect(validation).to eql(false)
              end
            end
          end

          context 'when absent' do
            it 'should fail validation' do
              request.response_group = nil
              expect(validation).to eql(false)
            end
          end
        end

        describe '#response_type' do
          context 'when present' do
            it "must be a valid code combination'" do
              %w/D1 D9 S1 S9/.each do |type|
                request.response_type = type
                expect(validation).to eql(true)
              end

              %w/a D0 S10 _/.each do |bad_type|
                request.response_type = bad_type
                expect(validation).to eql(false)
              end
            end
          end

          context 'when absent' do
            it 'should fail validation' do
              request.response_type = nil
              expect(validation).to eql(false)
            end
          end
        end

      end

      context 'with invalid items' do
        let(:request) {
          Suretax::Api::Request.new(suretax_valid_request_params)
        }

        before do
          request.items = [ Suretax::Api::RequestItem.new ]
        end

        it 'should be false' do
          expect(validation).to eql(false)
        end
      end
  end
end
