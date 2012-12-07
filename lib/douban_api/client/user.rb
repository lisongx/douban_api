# -*- encoding : utf-8 -*-
module Douban
  class Client
    # 豆瓣用户API V2 http://developers.douban.com/wiki/?title=user_v2
    module User
      
      # 获取用户信息
      # 
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=user_v2#get_user
      # @authenticated false
      # @param user_id [String] 用户uid或者数字id
      # @return [Hashie::Mash] 用户信息
      # @example 查看ahbei的信息
      #   Douban.user('ahbei')
      def user(user_id="~me")
        get "v2/user/#{user_id}"
      end
      
      # 获取当前授权用户信息
      # 
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=user_v2#get_me
      # @authenticated true
      # @return [Hashie::Mash] 用户信息
      # @example 获取当前授权用户信息
      #   client.me
      def me
        user
      end

      # 搜索用户
      # 
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=user_v2#search
      # @authenticated false
      # @param q [String] 全文检索的关键词
      # @return [Array<Hashie::Mash>] 用户信息列表
      # @example 获取当前授权用户信息
      #   Douban.search_users("傻多速")
      def search_users(q, options={})
        response = get "v2/user", options.merge(:q => q)
        response["users"]
      end
      alias :users :search_users
    end
  end
end
