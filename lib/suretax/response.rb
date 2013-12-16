require 'json'

module Suretax

  class Response
    attr_reader :response, :body, :status

    def initialize(response)
      @response = response
      sanitized_body = remove_xml_brackets(response.body)
      @body = JSON.parse(sanitized_body)
    end

    def success?
      response.success?
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
  end

end