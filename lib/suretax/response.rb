require 'json'

module Suretax

  class Response
    attr_reader :response, :body, :status, :api

    def initialize(api_response)
      @response = api_response
      sanitized_body = remove_xml_brackets(api_response.body)
      if sanitized_body == 'invalid request'
        @body = sanitized_body
        @status = 400
        @api = nil
        return self
      end
      @body = JSON.parse(sanitized_body)
      @api = Suretax::Api::Response.new(@body)
      @status = map_response_code_to_http_status(api.status)
    end

    def success?
      status == 200
    end

    private

    def extract_json_from_urlencoded_string_regex
      # http://rubular.com/r/0w73fy4Ldk
      /\A<\?xml.*<string[^>]+>(?<json_string>.+)<\/string>\z/m
    end

    def remove_xml_brackets(response_string)
      matches = response_string.match(extract_json_from_urlencoded_string_regex)
      matches['json_string']
    end

    def map_response_code_to_http_status(api_status_code)
      case api_status_code
      when '9999'
        200
      when '9001'
        409
      else
        400
      end
    end

  end

end
