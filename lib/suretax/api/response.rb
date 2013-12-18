module Suretax
  module Api
    class Response
      attr_reader :status, :message, :total_tax

      def initialize(response_body)
        @status = response_body.fetch('ResponseCode')
        @message = response_body.fetch('HeaderMessage')
        @success = response_body.fetch('Successful') == 'Y'
        @total_tax = Suretax::Api::TaxAmount.new(response_body['TotalTax'])
      end

      def success?
        @success
      end

    end
  end
end

