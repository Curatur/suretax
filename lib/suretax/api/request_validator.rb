module Suretax
  module Api
    class RequestValidator

      class << self
        attr_reader :request
      end

      def self.valid?(request)
        @request = request
        is_a_list?(request.items) &&
        is_nine_digits?(request.client_number) &&
        is_a_year?(request.data_year) &&
        is_a_month_number?(request.data_month) &&
        validate_list(request.items)

      end

      private

      def self.validate_list(list)
        !list.map { |i| i.valid? }.include?(false)
      end


      def self.is_a_year?(value)
        match = value =~ /\A(?:19|20)\d{2}\z/
        !match.nil?
      end

      def self.is_a_month_number?(value)
        match = value =~ /\A#{(1..12).to_a.join('|')}\z/
        !match.nil?
      end

      def self.is_a_list?(value)
        value.respond_to?(:each)
      end

      def self.is_nine_digits?(value)
        is_a_number?(value) && value.length == 9
      end

      def self.is_a_number?(value)
        match = value =~ /\A\d+\z/
        !match.nil?
      end
    end
  end
end
