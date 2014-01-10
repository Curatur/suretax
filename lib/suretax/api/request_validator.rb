module Suretax
  module Api
    module RequestValidator

      extend Suretax::Concerns::Validatable

      def self.valid?(request)
        is_a_valid_list?(request.items) &&
          is_a_valid_client_number?(request.client_number) &&
          is_a_valid_business_unit?(request.business_unit) &&
          is_a_valid_validation_key?(request.validation_key) &&
          is_a_valid_data_year?(request.data_year) &&
          is_a_valid_data_month?(request.data_month) &&
          is_a_valid_total_revenue?(request.total_revenue) &&
          is_a_valid_return_file_code?(request.return_file_code) &&
          is_a_valid_client_tracking?(request.client_tracking) &&
          is_a_valid_response_group?(request.response_group) &&
          is_a_valid_response_type?(request.response_type) &&
          validate_list(request.items)
      end
    end
  end
end
