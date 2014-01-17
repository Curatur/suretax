module Suretax::Concerns
  module Validatable

    def validate_list(list)
      !list.map { |i| i.valid? }.include?(false)
    end

    def valid_data_year?(value)
      return false if blank?(value)
      value.length == 4 &&
        (value.to_i <= 2050 && value.to_i >= 1990)
    end

    def valid_data_month?(value)
      matches?(value,month_list_subexpression)
    end

    def month_list_subexpression
      # Month numbers 1-12 with optional leading zero
      "0?(?:" + (1..12).to_a.join('|') + ")"
    end

    def valid_list?(value)
      value.respond_to?(:each)
    end

    def valid_client_number?(value)
      return false if blank?(value)
      numeric?(value) && value.length <= 10
    end

    def valid_business_unit?(value)
      return true if blank?(value)
      value.length <= 20 && alphanumeric?(value)
    end

    def valid_validation_key?(value)
      return false if blank?(value)
      value.length <= 36
    end

    def valid_total_revenue?(value)
      matches?(value, total_revenue_positive_subexpression) ||
        matches?(value, total_revenue_negative_subexpression)
    end

    def total_revenue_negative_subexpression
      '-\d{,8}(?:\.\d{,4})?'
    end

    def total_revenue_positive_subexpression
      '\d{,9}(?:\.\d{,4})?'
    end

    def valid_return_file_code?(value)
      matches?(value.to_s,'[Q0]')
    end

    def valid_client_tracking?(value)
      return true if blank?(value)
      value.length <= 100
    end

    def valid_response_group?(value)
      %w/00 01 02 03/.include?(value)
    end

    def valid_response_type?(value)
      matches?(value, '[DS][1-9]')
    end

    def valid_line_number?(value)
      return true if blank?(value)
      value.length <= 20 && numeric?(value)
    end

    def valid_invoice_number?(value)
      return true if blank?(value)
      value.length <= 20 && alphanumeric?(value)
    end

    def valid_tax_situs_rule?(value)
      %w/01 02 03 04 05 06 07 14/.include?(value)
    end

    def valid_trans_type_code?(value)
      return false if blank?(value)
      true
    end

    def valid_sales_type_code?(value)
      return false if blank?(value)
      matches?(value,'[RBIL]')
    end

    def valid_regulatory_code?(value)
      return false if blank?(value)
      %w/00 01 02 03 04 05 99/.include?(value)
    end

    def valid_tax_exemption_code_list?(value)
      valid_list?(value) && !blank?(value.first)
    end

    def optional_north_american_phone_number?(value)
      return true if blank?(value)
      north_american_phone_number?(value)
    end

    def north_american_phone_number?(value)
      return false if blank?(value)
      value.length == 10 && numeric?(value)
    end

    def numeric?(value)
      matches?(value,'\d+')
    end

    def alphanumeric?(value)
      matches?(value,'[a-z0-9]+')
    end

    def blank?(value)
      return true if value.nil?
      matches?(value,'\s*')
    end

    def matches?(value,subexpression)
      match = value =~ /\A#{subexpression}\z/i
      !match.nil?
    end
  end
end
