# -*- encoding : utf-8 -*-
require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)
require File.expand_path('../oauth', __FILE__)

module Douban
  # @private
  class API
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = Douban.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def get_rate_limit_info
      @rate_limit_info || {}
    end

    include Connection
    include Request
    include OAuth
  end
end
