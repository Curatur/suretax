module Suretax
  module Api
    module RequestItemValidator

      extend Suretax::Concerns::Validatable

      def self.valid?(item)
        valid_client_number?(item.customer_number) &&
          valid_invoice_number?(item.invoice_number) &&
          valid_tax_situs_rule?(item.tax_situs_rule) &&
          optional_north_american_phone_number?(item.orig_number) &&
          optional_north_american_phone_number?(item.term_number) &&
          optional_north_american_phone_number?(item.bill_to_number) &&
          valid_trans_type_code?(item.trans_type_code) &&
          valid_sales_type_code?(item.sales_type_code) &&
          valid_regulatory_code?(item.regulatory_code) &&
          valid_tax_exemption_code_list?(item.tax_exemption_codes) &&
          valid_line_number?(item.line_number)
      end
    end
  end
end
