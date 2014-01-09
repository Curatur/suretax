module Suretax
  module Api
    module RequestItemValidator

      extend Suretax::Concerns::Validatable

      def self.valid?(item)
        is_a_list?(item.tax_exemption_codes) &&
          is_nine_digits?(item.customer_number) &&
          is_a_number?(item.invoice_number)
      end
    end
  end
end
