module Suretax
  module Api
    module RequestValidator

      extend Suretax::Concerns::Validatable

      def self.valid?(request)
        valid_list?(request.items) &&
          valid_client_number?(request.client_number) &&
          valid_business_unit?(request.business_unit) &&
          valid_validation_key?(request.validation_key) &&
          valid_data_year?(request.data_year) &&
          valid_data_month?(request.data_month) &&
          valid_total_revenue?(request.total_revenue) &&
          valid_return_file_code?(request.return_file_code) &&
          valid_client_tracking?(request.client_tracking) &&
          valid_response_group?(request.response_group) &&
          valid_response_type?(request.response_type) &&
          validate_list(request.items)
      end
    end
  end
end
