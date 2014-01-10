module Suretax::Concerns
  module Validatable

    def validate_list(list)
      !list.map { |i| i.valid? }.include?(false)
    end

    def is_a_valid_data_year?(value)
      return false if is_blank?(value)
      value.length == 4 &&
        matches?(value,(1990..2050).to_a.join('|'))
    end

    def is_a_valid_data_month?(value)
      match_list = "0?(?:" + (1..12).to_a.join('|') + ")"
      matches?(value,match_list)
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
      matches?(value, '\d{,9}(?:\.\d{,4})?') ||
        matches?(value, '-\d{,8}(?:\.\d{,4})?')
    end

    def is_a_valid_return_file_code?(value)
      matches?(value.to_s,'[Q0]')
    end

    def is_a_valid_client_tracking?(value)
      return true if is_blank?(value)
      value.length <= 100
    end

    def is_a_valid_response_group?(value)
      matches?(value, '00|01|02|03')
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
      (("01".."07").to_a + ["14"]).include?(value)
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
