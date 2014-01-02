module Suretax
  module Api
    module RequestItemValidator

      class << self
        attr_reader :item
      end

      def self.valid?(request_item)
        @item = request_item
        validate_tax_exemption_codes &&
          customer_number_is_nine_digits &&
          is_a_number?(item.invoice_number)
      end

      private

      def self.validate_tax_exemption_codes
        item.tax_exemption_codes.respond_to?(:each)
      end

      def self.customer_number_is_nine_digits
        value = item.customer_number
        is_a_number?(value) && value.length == 9
      end

      def self.is_a_number?(value)
        match = value =~ /\A\d+\z/
        !match.nil?
      end


    end
  end
end
__END__
bill_to_number: "8585260000",
      invoice_number: "1",
      line_number: "1",
      orig_number: "8585260000",
      p_to_p_plus_four: "",
      p_to_p_zipcode: "",
      plus_four: "",
      regulatory_code: "99",
      revenue: "40",
      sales_type_code: "R",
      seconds: "55",
      tax_included_code: "0",
      tax_situs_rule: "01",
      term_number: "8585260000",
      trans_date: "2013-12-01T00:00:00",
      trans_type_code: "010101",
      unit_type: "00",
      units: "1",
      zipcode: ""
