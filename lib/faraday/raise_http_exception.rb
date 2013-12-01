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
          raise Douban::BadRequest.new(response)
        when 404
          raise Douban::NotFound.new(response)
        when 500
          raise Douban::InternalServerError.new(response, "Something is technically wrong.")
        when 503
          raise Douban::ServiceUnavailable.new(response, "Douban is rate limiting your requests.")
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private


  end
end
