# -*- encoding : utf-8 -*-
module Douban
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false)
      request(:get, path, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, options={}, raw=false)
      request(:post, path, options, raw)
    end

    # Perform an HTTP PUT request
    def put(path, options={}, raw=false)
      request(:put, path, options, raw)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, raw=false)
      request(:delete, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options={}, raw=false)
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
      end

      @rate_limit_info = extract_rate_limit_info(response.headers)

      raw ? response : response.body
    end

    def extract_rate_limit_info(headers)
      headers.reject do |k, v|
        !['x-ratelimit-limit',
          'x-ratelimit-limit2',
          'x-ratelimit-remaining',
          'x-ratelimit-remaining2'
        ].include?(k)
      end
    end
  end
end
