# -*- encoding : utf-8 -*-
require File.expand_path('../douban_api/error', __FILE__)
require File.expand_path('../douban_api/configuration', __FILE__)
require File.expand_path('../douban_api/api', __FILE__)
require File.expand_path('../douban_api/client', __FILE__)

module Douban
  extend Configuration

  # Alias for Douban::Client.new
  #
  # @return [Douban::Client]
  def self.client(options={})
    Douban::Client.new(options)
  end

  # Delegate to Douban::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Douban::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
  
end
