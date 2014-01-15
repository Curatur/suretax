module Suretax::Concerns
  module Validatable

    def validate_list(list)
      !list.map { |i| i.valid? }.include?(false)
    end

    def is_a_valid_data_year?(value)
      return false if is_blank?(value)
      value.length == 4 &&
        (value.to_i <= 2050 && value.to_i >= 1990)
    end

    def is_a_valid_data_month?(value)
      matches?(value,month_list_subexpression)
    end

    def month_list_subexpression
      # Month numbers 1-12 with optional leading zero
      "0?(?:" + (1..12).to_a.join('|') + ")"
    end

    def is_a_valid_list?(value)
      value.respond_to?(:each)
    end

    def is_a_valid_client_number?(value)
      return false if is_blank?(value)
      is_numeric?(value) && value.length <= 10
    end

    def is_a_valid_business_unit?(value)
      return true if is_blank?(value)
      value.length <= 20 && is_alphanumeric?(value)
    end

    def is_a_valid_validation_key?(value)
      return false if is_blank?(value)
      value.length <= 36
    end

    def is_a_valid_total_revenue?(value)
      matches?(value, total_revenue_positive_subexpression) ||
        matches?(value, total_revenue_negative_subexpression)
    end

    def total_revenue_negative_subexpression
      '-\d{,8}(?:\.\d{,4})?'
    end

    def total_revenue_positive_subexpression
      '\d{,9}(?:\.\d{,4})?'
    end

    def is_a_valid_return_file_code?(value)
      matches?(value.to_s,'[Q0]')
    end

    def is_a_valid_client_tracking?(value)
      return true if is_blank?(value)
      value.length <= 100
    end

    def is_a_valid_response_group?(value)
      %w/00 01 02 03/.include?(value)
    end

    def is_a_valid_response_type?(value)
      matches?(value, '[DS][1-9]')
    end

    def is_a_valid_line_number?(value)
      return true if is_blank?(value)
      value.length <= 20 && is_numeric?(value)
    end

    def is_a_valid_invoice_number?(value)
      return true if is_blank?(value)
      value.length <= 20 && is_alphanumeric?(value)
    end

    def is_a_valid_tax_situs_rule?(value)
      %w/01 02 03 04 05 06 07 14/.include?(value)
    end

    def is_a_valid_trans_type_code?(value)
      return false if is_blank?(value)
      true
    end

    def is_a_valid_sales_type_code?(value)
      return false if is_blank?(value)
      matches?(value,'[RBIL]')
    end

    def is_a_valid_regulatory_code?(value)
      return false if is_blank?(value)
      %w/00 01 02 03 04 05 99/.include?(value)
    end

    def is_a_valid_tax_exemption_code_list?(value)
      is_a_valid_list?(value) && !is_blank?(value.first)
    end

    def is_an_optional_north_american_phone_number?(value)
      return true if is_blank?(value)
      is_a_north_american_phone_number?(value)
    end

    def is_a_north_american_phone_number?(value)
      return false if is_blank?(value)
      value.length == 10 && is_numeric?(value)
    end

    def is_numeric?(value)
      matches?(value,'\d+')
    end

    def is_alphanumeric?(value)
      matches?(value,'[a-z0-9]+')
    end

    def is_blank?(value)
      return true if value.nil?
      matches?(value,'\s*')
    end

    def matches?(value,subexpression)
      match = value =~ /\A#{subexpression}\z/i
      !match.nil?
    end
  end
end
