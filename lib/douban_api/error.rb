# -*- encoding : utf-8 -*-
module Douban
  # Custom error class for rescuing from all Douban errors
  class Error < StandardError
    attr_reader :code, :msg

    def initialize(response, message = nil)
      parse_response_body(response[:body])

      super(create_message(response, message))
    end

    private
    def parse_response_body(body)
      @code, @msg = 0, ""

      # body gets passed as a string, not sure if it is passed as something else from other spots?
      if not body.nil? and not body.empty? and body.kind_of?(String)
        # removed multi_json thanks to wesnolte's commit
        body = ::JSON.parse(body)

        if body['code'] and body['msg']
          @code, @msg = body['code'].to_i, body['msg']
        end
      end
    end

    def create_message(response, message)
      if @code == 0
        details = message
      else
        details = "Douban ERROR #{@code} - #{@msg}"
      end

      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status].to_s}, #{details}"
    end
  end

  # Raised when Douban returns the HTTP status code 400
  class BadRequest < Error;  end

  # Raised when Douban returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Douban returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Douban returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when a subscription payload hash is invalid
  class InvalidSignature < Error; end
end
