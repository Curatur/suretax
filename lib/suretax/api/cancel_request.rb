module Suretax
  module Api
    class CancelRequest
      attr_accessor :client_number, :validation_key, :transaction, :client_tracking

      def initialize(options={})
        self.client_number    = options.delete(:client_number)  || configuration.client_number
        self.validation_key   = options.delete(:validation_key) || configuration.validation_key

        options.each_pair do |key,value|
          self.send("#{key.to_s}=",value.to_s)
        end
      end

      def submit
        suretax_response = connection.cancel(params)
        @response = Suretax::Api::Response.new(suretax_response.body)
      end

      def params
        {
          "ClientNumber"   => client_number,
          "ClientTracking" => client_tracking,
          "TransId"        => transaction,
          "ValidationKey"  => validation_key
        }
      end

      private

      def configuration
        Suretax.configuration
      end
    end
  end
end
