module Suretax
  module Api
    class ValidationError < StandardError; end

    class Request

      include Suretax::Concerns::Validatable

      attr_accessor :business_unit,
                    :client_number,
                    :client_tracking,
                    :data_month,
                    :data_year,
                    :industry_exemption,
                    :response_group,
                    :response_type,
                    :return_file_code,
                    :total_revenue,
                    :validation_key,
                    :items,
                    :response

      validate :client_number,
               :business_unit,
               :validation_key,
               :data_year,
               :data_month,
               :total_revenue,
               :return_file_code,
               :client_tracking,
               :response_group,
               :response_type,
               :items

      def initialize(options = {})
        self.return_file_code = '0'
        self.client_number    = options.delete(:client_number)  || configuration.client_number
        self.validation_key   = options.delete(:validation_key) || configuration.validation_key

        options.each_pair do |key,value|
          self.send("#{key.to_s}=", value.to_s)
        end

        self.items = []
        if options[:items].respond_to?(:each)
          options[:items].each do |item_args|
            self.items << RequestItem.new(item_args)
          end
        end

        validate!
      end

      def submit
        if valid?
          suretax_response = connection.post(params)
          @response = Suretax::Api::Response.new(suretax_response.body)
        else
          raise(ValidationError, errors.messages.join(", "))
        end
      end

      def valid?
        !errors.any?
      end

      def rollback
        if response
          CancelRequest.new(transaction: response.transaction, 
            client_number: client_number, validation_key: validation_key,
            client_tracking: client_tracking).submit
        end
      end

      def params
        {
          "BusinessUnit"             => business_unit,
          "ClientNumber"             => client_number,
          "ClientTracking"           => client_tracking,
          "DataMonth"                => data_month,
          "DataYear"                 => data_year,
          "IndustryExemption"        => industry_exemption,
          "ItemList"                 => items.map { |item| item.params },
          "ResponseGroup"            => response_group,
          "ResponseType"             => response_type,
          "ReturnFileCode"           => return_file_code,
          "TotalRevenue"             => total_revenue,
          "ValidationKey"            => validation_key
        }
      end

      private

      def configuration
        Suretax.configuration
      end

      def connection
        @connection ||= Connection.new
      end
    end
  end
end
