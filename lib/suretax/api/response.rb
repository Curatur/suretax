module Suretax
  module Api
    class Response
      attr_reader :status, :message, :total_tax, :groups, :transaction, :client_tracking

      def initialize(response_body)
        @status = response_body.fetch('ResponseCode')
        @transaction = response_body.fetch('TransId').to_s
        @message = response_body.fetch('HeaderMessage')
        @success = response_body.fetch('Successful') == 'Y'
        @client_tracking = response_body['ClientTracking'] || nil
        @total_tax = Amount.new(response_body['TotalTax'])
        @groups = []
        if response_body['GroupList'].respond_to?(:map)
          @groups = response_body.fetch('GroupList').map do |group|
            Group.new(group)
          end
        end
      end

      def success?
        @success
      end

    end
  end
end

