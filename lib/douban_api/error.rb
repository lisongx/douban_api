# -*- encoding : utf-8 -*-
module Douban
  # Custom error class for rescuing from all Douban errors
  class Error < StandardError; end

  # Raised when Douban returns the HTTP status code 400
  class BadRequest < Error
    attr_reader :code, :msg

    def initialize(body)
      @code, @msg = 0, ""
      parse_error_body(body)
    end

    private
    def parse_error_body(body)
      # body gets passed as a string, not sure if it is passed as something else from other spots?
      if not body.nil? and not body.empty? and body.kind_of?(String)
        # removed multi_json thanks to wesnolte's commit
        body = ::JSON.parse(body)

        if body['code'] and body['msg']
          @code, @msg = body['code'], body['msg']
        end
      end
    end
  end

  # Raised when Douban returns the HTTP status code 404
  class NotFound < BadRequest; end

  # Raised when Douban returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Douban returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when a subscription payload hash is invalid
  class InvalidSignature < Error; end
end
