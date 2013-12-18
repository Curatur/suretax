module Suretax
  module Api
    class Response
      attr_reader :status, :message, :total_tax, :groups

      def initialize(response_body)
        @status = response_body.fetch('ResponseCode')
        @message = response_body.fetch('HeaderMessage')
        @success = response_body.fetch('Successful') == 'Y'
        @total_tax = TaxAmount.new(response_body['TotalTax'])
        @groups = response_body.fetch('GroupList').map do |group|
          Group.new(group)
        end
      end

      def success?
        @success
      end

    end
  end
end

