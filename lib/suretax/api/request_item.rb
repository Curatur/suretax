module Suretax
  module Api

    class RequestItem

      include Suretax::Concerns::Validatable

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

      validate :bill_to_number,
               :customer_number,
               :invoice_number,
               :line_number,
               :orig_number,
               :regulatory_code,
               :sales_type_code,
               :tax_situs_rule,
               :term_number,
               :trans_type_code,
               :tax_exemption_codes

      def initialize(args = {})
        args.each_pair do |key,value|
          self.send("#{key.to_s}=",value.to_s)
        end

        @tax_exemption_codes = []
        unless args[:tax_exemption_codes].nil?
          args[:tax_exemption_codes].each do |code|
            @tax_exemption_codes << code.to_s
          end
        end

        validate!
      end

      def params
        {
          "LineNumber"           => line_number,
          "InvoiceNumber"        => invoice_number,
          "CustomerNumber"       => customer_number,
          "OrigNumber"           => orig_number      || '',
          "TermNumber"           => term_number      || '',
          "BillToNumber"         => bill_to_number   || '',
          "Zipcode"              => zipcode,
          "Plus4"                => plus_four,
          "P2PZipcode"           => p_to_p_zipcode   || '',
          "P2PPlus4"             => p_to_p_plus_four || '',
          "TransDate"            => trans_date       || Date.today.strftime('%m-%d-%Y'),
          "Revenue"              => revenue.to_f,
          "Units"                => units.to_i,
          "UnitType"             => unit_type        || '00',
          "Seconds"              => seconds.to_i,
          "TaxIncludedCode"      => tax_included_code,
          "TaxSitusRule"         => tax_situs_rule,
          "TransTypeCode"        => trans_type_code,
          "SalesTypeCode"        => sales_type_code,
          "RegulatoryCode"       => regulatory_code,
          "TaxExemptionCodeList" => tax_exemption_codes
        }
      end
    end
  end
end
