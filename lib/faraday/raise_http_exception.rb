# -*- encoding : utf-8 -*-
require 'faraday'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise Douban::BadRequest.new(response[:body]), error_message_400(response)
        when 404
          raise Douban::NotFound.new(response[:body]), error_message_400(response)
        when 500
          raise Douban::InternalServerError, error_message_500(response, "Something is technically wrong.")
        when 503
          raise Douban::ServiceUnavailable, error_message_500(response, "Douban is rate limiting your requests.")
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}"
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end
