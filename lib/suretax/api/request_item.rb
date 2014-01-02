require 'suretax/api/request_item_validator'

module Suretax
  module Api

    class RequestItem
      attr_accessor :bill_to_number,
                    :customer_number,
                    :invoice_number,
                    :line_number,
                    :orig_number,
                    :p_to_p_plus_four,
                    :p_to_p_zipcode,
                    :plus_four,
                    :regulatory_code,
                    :revenue,
                    :sales_type_code,
                    :seconds,
                    :tax_included_code,
                    :tax_situs_rule,
                    :term_number,
                    :trans_date,
                    :trans_type_code,
                    :unit_type,
                    :units,
                    :zipcode,
                    :tax_exemption_codes

      def initialize(args = {})
        args.each_pair do |key,value|
          self.send("#{key.to_s}=",value)
        end
        @tax_exemption_codes = []
        unless args[:tax_exemption_codes].nil?
          args[:tax_exemption_codes].each do |code|
            @tax_exemption_codes << code
          end
        end
      end

      def valid?
        RequestItemValidator.valid?(self)
      end

      def params
        {
          "BillToNumber"         => bill_to_number,
          "CustomerNumber"       => customer_number,
          "InvoiceNumber"        => invoice_number,
          "LineNumber"           => line_number,
          "OrigNumber"           => orig_number,
          "P2PPlus4"             => p_to_p_plus_four,
          "P2PZipcode"           => p_to_p_zipcode,
          "Plus4"                => plus_four,
          "RegulatoryCode"       => regulatory_code,
          "Revenue"              => revenue,
          "SalesTypeCode"        => sales_type_code,
          "Seconds"              => seconds,
          "TaxExemptionCodeList" => tax_exemption_codes,
          "TaxIncludedCode"      => tax_included_code,
          "TaxSitusRule"         => tax_situs_rule,
          "TermNumber"           => term_number,
          "TransDate"            => trans_date,
          "TransTypeCode"        => trans_type_code,
          "UnitType"             => unit_type,
          "Units"                => units,
          "Zipcode"              => zipcode
        }
      end
    end
  end
end
__END__
