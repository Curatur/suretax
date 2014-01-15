module Suretax
  module Api
    module RequestItemValidator

      extend Suretax::Concerns::Validatable

      def self.valid?(item)
        is_a_valid_client_number?(item.customer_number) &&
          is_a_valid_invoice_number?(item.invoice_number) &&
          is_a_valid_tax_situs_rule?(item.tax_situs_rule) &&
          is_an_optional_north_american_phone_number?(item.orig_number) &&
          is_an_optional_north_american_phone_number?(item.term_number) &&
          is_an_optional_north_american_phone_number?(item.bill_to_number) &&
          is_a_valid_trans_type_code?(item.trans_type_code) &&
          is_a_valid_sales_type_code?(item.sales_type_code) &&
          is_a_valid_regulatory_code?(item.regulatory_code) &&
          is_a_valid_tax_exemption_code_list?(item.tax_exemption_codes) &&
          is_a_valid_line_number?(item.line_number)
      end
    end
  end
end
