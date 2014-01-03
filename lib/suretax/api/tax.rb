module Suretax
  module Api
    class Tax
      attr_reader :code, :description, :amount

      def initialize(response_params)
        @code = response_params.fetch('TaxTypeCode')
        @description = response_params.fetch('TaxTypeDesc')
        @amount = Amount.new(response_params.fetch('TaxAmount'))
      end

    end
  end
end
