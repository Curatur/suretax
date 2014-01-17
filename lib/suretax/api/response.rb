module Suretax
  module Api
    class Response
      attr_reader :status, :message, :total_tax, :groups, :transaction

      def initialize(response_body)
        @status = response_body.fetch('ResponseCode')
        @transaction = response_body.fetch('TransId').to_s
        @message = response_body.fetch('HeaderMessage')
        @success = response_body.fetch('Successful') == 'Y'
        @total_tax = Amount.new(response_body['TotalTax'])
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

