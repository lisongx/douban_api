# -*- encoding : utf-8 -*-
require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module Douban
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => endpoint,
      }

      Faraday::Connection.new(options) do |connection|
        # requests
        connection.use FaradayMiddleware::OAuth2, client_id, access_token
        connection.use Faraday::Request::Multipart
        connection.use Faraday::Request::UrlEncoded

        # responses
        connection.use FaradayMiddleware::Mashify unless raw
        unless raw
          case format.to_s.downcase
          when 'json' then connection.use Faraday::Response::ParseJson
          end
        end
        connection.use FaradayMiddleware::RaiseHttpException
        # connection.use Faraday::Response::Logger

        # adapter
        connection.adapter(adapter)
      end
    end
  end
end
