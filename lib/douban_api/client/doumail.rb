# -*- encoding : utf-8 -*-
module Douban
  class Client
    # 豆邮Api V2 http://developers.douban.com/wiki/?title=doumail_v2
    module Doumail

      # 获取一封邮件
      #
      # @see http://developers.douban.com/wiki/?title=doumail_v2#get_mail
      # @douban.scope community_advanced_doumail_r
      # @authenticated true
      # @param id [String] 豆邮的id
      # @return [Hashie::Mash] 豆邮信息
      # @example 获取 id为281922967 的豆邮
      #   client.doumail('281922967')
      def doumail(id, keep_unread=false)
        response = get("v2/doumail/#{id}", :"keep-unread" => keep_unread)
      end

      # 获取用户收件箱
      #
      # @see http://developers.douban.com/wiki/?title=doumail_v2#inbox
      # @douban.scope community_advanced_doumail_r
      # @authenticated true
      # @return [Array<Hashie::Mash>] 豆邮列表
      # @example 获取当前用户的收件箱
      #   client.inbox
      def inbox(options={})
        response = get "v2/doumail/inbox"
        response["mails"]
      end

      # 获取用户发件箱
      #
      # @see http://developers.douban.com/wiki/?title=doumail_v2#outbox
      # @douban.scope community_advanced_doumail_r
      # @authenticated true
      # @return [Array<Hashie::Mash>] 豆邮列表
      # @example 获取当前用户的发件箱
      #   client.outbox
      def outbox(options={})
        response = get "v2/doumail/outbox"
        response["mails"]
      end

      # 获取用户未读邮件
      #
      # @see http://developers.douban.com/wiki/?title=doumail_v2#unread
      # @douban.scope community_advanced_doumail_r
      # @authenticated true
      # @return [Array<Hashie::Mash>] 豆邮列表
      # @example 获取当前用户未读邮件
      #   client.unread
      def unread(options={})
        response = get "v2/doumail/inbox/unread"
        response["mails"]
      end

      # 标记已读邮件
      #
      # @see http://developers.douban.com/wiki/?title=doumail_v2#read
      # @douban.scope community_advanced_doumail_w
      # @authenticated true
      # @param id [Array<String>, String] 豆邮id的列表或豆邮的id
      # @return [Array<Hashie::Mash>, Hashie::Mash] 豆邮信息或者豆邮列表
      # @example 标记id为281740901的
      #   client.read("281740901")
      # @example 标记多个豆邮为已读
      #   client.read(["281740901", "281745597"])
      def read(id)
        if id.is_a?(Array)
          response = put("v2/doumail/read", :ids => id.join(','))
          response["doumails"]
        else 
          put "v2/doumail/#{id}"
        end
      end

      # 删除豆邮
      #
      # @see http://developers.douban.com/wiki/?title=doumail_v2#delete
      # @douban.scope community_advanced_doumail_w
      # @authenticated true
      # @param id [Array<String>, String] 豆邮id的列表或豆邮的id
      # @return [Hashie::Mash] 豆邮信息
      # @example 删除id为281740901的删除
      #   client.delete_doumail("281740901")
      # @example 删除多个豆邮
      #   client.delete_doumail(["281740901", "281745597"])
      def delete_doumail(id)
        if id.kind_of?(Array)
          post "v2/doumail/delete", :ids => id.join(',')
        else
          post "v2/doumail/#{id}"
        end
      end
      
      # 发送一封豆邮
      #
      # @see http://developers.douban.com/wiki/?title=doumail_v2#send
      # @douban.scope community_advanced_doumail_w
      # @authenticated true
      # @param receiver_id [String] 收件人的id
      # @option options [String] :title 豆邮标题:  必填字段
      # @option options [String] :content 豆邮正文: 必填字段
      # @option options [String] :captcha_token 系统验证码 token: 选填字段
      # @option options [String] :captcha_string 用户输入验证码: 选填字段
      # @return [Hashie::Mash] 豆邮信息
      # @example 发送一封豆邮
      #   client.send_doumail('48576635', {
      #     :title => "test",
      #     :content => "只是test"
      #   })
      def send_doumail(receiver_id, options={})
        options["receiver_id"] = receiver_id
        post("v2/doumails", options) == {}
      end
    end
  end
end
