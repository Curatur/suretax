module Suretax
  module Api
    class TaxAmount
      attr_reader :precision, :divisor

      def initialize(amount)
        if amount =~ /\A[\d\.]+\z/
          @amount = amount
          number_parts = amount.to_s.match(/\A(?<whole>\d+)\.?(?<fractional>\d+)?\z/)
          @precision = number_parts['fractional'].length
          @divisor = 10**@precision
        else
          @amount = 0
          @precision = 0
          @divisor = 1
        end
      end

      def to_f
        @amount.to_f
      end

      def to_s
        @amount
      end

      def to_i
        (to_f * @divisor).to_i
      end

      def total_cents
        (("%.2f" % to_f).to_f * 100 ).to_i
      end

      def params
        { 
          amount: to_i,
          precision: precision,
          divisor: divisor
        }
      end

    end
  end
end
