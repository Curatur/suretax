require 'suretax/validatable'

module Suretax
  module Validatable

    def validate_list(list)
      !list.map { |i| i.valid? }.include?(false)
    end

    def is_a_year?(value)
      match = value =~ /\A(?:19|20)\d{2}\z/
      !match.nil?
    end

    def is_a_month_number?(value)
      match = value =~ /\A#{(1..12).to_a.join('|')}\z/
      !match.nil?
    end

    def is_a_list?(value)
      value.respond_to?(:each)
    end

    def is_nine_digits?(value)
      is_a_number?(value) && value.length == 9
    end

    def is_a_number?(value)
      match = value =~ /\A\d+\z/
      !match.nil?
    end
  end
end
