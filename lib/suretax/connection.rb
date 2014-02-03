require 'faraday'
require 'uri'
require 'json'

module Suretax

  class Connection
    attr_accessor :headers

    def initialize(args = {})
      @link = Faraday.new( url: args[:base_url] || configuration.base_url )
      @headers = @link.headers
      headers['Content-Type'] = 'application/x-www-form-urlencoded'
    end

    def post(body = {}, path = default_post_path)
      Response.new(@link.post(path, encode_body(body)))
    end

    def cancel(body = {}, path = default_cancel_path)
      Response.new(@link.post(path, encode_body(body)))
    end

    private

    def encode_body(request_hash)
      json_body = JSON.generate(request_hash)
      "request=#{URI.encode_www_form_component(json_body)}"
    end

    def default_post_path
      configuration.post_path
    end

    def default_cancel_path
      configuration.cancel_path
    end

    def configuration
      Suretax.configuration
    end
  end

end
