module Suretax
  module Api
    class Group
      attr_reader :state, :customer, :invoice, :taxes

      def initialize(response_params)
        @state = response_params.fetch('StateCode')
        @invoice = response_params.fetch('InvoiceNumber')
        @customer = response_params.fetch('CustomerNumber')
        @taxes = response_params.fetch('TaxList').map do |tax|
          Suretax::Api::Tax.new(tax)
        end
      end

    end
  end
end
