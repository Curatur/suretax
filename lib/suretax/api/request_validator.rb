require 'suretax/validatable'

module Suretax
  module Api
    module RequestValidator

      extend Suretax::Validatable

      def self.valid?(request)
        is_a_list?(request.items) &&
          is_nine_digits?(request.client_number) &&
          is_a_year?(request.data_year) &&
          is_a_month_number?(request.data_month) &&
          validate_list(request.items)
      end
    end
  end
end
