# -*- encoding : utf-8 -*-
module Douban
  class Client
    # 豆瓣广播 Api V2 http://developers.douban.com/wiki/?title=shuo_v2
    module Shuo
      # 发送一条广播
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param text [String] 广播文本内容
      # @option options [String] :rec_title 推荐网址的标题
      # @option options [String] :rec_url 推荐网址的href
      # @option options [String] :rec_desc 推荐网址的描述
      # @return [Hashie::Mash] 发送成功的广播数据
      # @example 发送一条广播
      #   client.create_status("嘻嘻")
      # TODO 支持附带图片的广播
      def create_status(text, options={})
        options.merge!(:text => text, :source => client_id)
        post "shuo/v2/statuses/", options
      end
      alias :shuo :create_status

      # 友邻广播
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated true
      # @option options [Integer] :since_id
      #   若指定此参数，则只返回ID比since_id大的广播消息（即比since_id发表时间晚的广播消息）。
      # @option options [Integer] :until_id 
      #   若指定此参数，则返回ID小于或等于until_id的广播消息
      # @return [Array<Hashie::Mash>] 广播列表
      # @example 获取当前认证用户的友邻广播
      #   client.timeline
      def timeline(options={})
        get "shuo/v2/statuses/home_timeline", options
      end

      # 获取用户发布的广播列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param name [String] 用户uid或者数字id      
      # @option options [Integer] :since_id
      #   若指定此参数，则只返回ID比since_id大的广播消息（即比since_id发表时间晚的广播消息）。
      # @option options [Integer] :until_id 
      #   若指定此参数，则返回ID小于或等于until_id的广播消息
      # @return [Array<Hashie::Mash>] 广播列表
      # @example 获取ahbei的广播列表
      #   Douban.user_timeline('ahbei')
      def user_timeline(name=nil, options={})
          get "shuo/v2/statuses/user_timeline/#{name}", options
      end


      # 读取一条广播
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param id [String] 广播的id
      # @option pack [Boolean] 是否打包 resharers 和 comments 数据
      # @return [Hashie::Mash] 广播信息
      # @example 获取id为1057462112的广播，并且包含resharers 和 comments 数据
      #   Douban.status('1057462112', true)
      def status(id, pack=false)
        get "shuo/v2/statuses/#{id}", :pack => pack
      end

      # 删除一条广播(只有删除自己的广播)
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param id [String] 广播的id
      # @return [Boolean] 删除成功则返回true, 否则false      
      # @example 删除id为1057462112的广播
      #   client.remove_status('1057462112')
      def remove_status(id)
        begin
          delete "shuo/v2/statuses/#{id}"
          return true
        rescue Douban::NotFound
          return false
        end
      end

      # 获取一条广播的回复列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param id [String] 广播的id
      # @return [Array<Hashie::Mash>] 评论列表
      # @example 获取id为1056160363的广播的评论
      #   Douban.status_comments('1056160363')
      def status_comments(id, options={})
        get "shuo/v2/statuses/#{id}/comments", options
      end
      
      # 添加一条评论
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param id [String] 广播的id
      # @param text [String] 评论的文本
      # @return [Hashie::Mash] 广播信息
      # @example 评论一个条广播
      #   client.create_status_comment('1057158586', "谢谢啊！")
      # TODO report to douban api team
      def create_status_comment(id, text)
        post "shuo/v2/statuses/#{id}/comments", options.merge(:text => text)
      end

      # 获取单条回复的内容
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param id [String] 评论的id
      # @return [Hashie::Mash] 评论信息
      # @example 获取 id 为2998638 的评论
      #   Douban.comment('2998638')
      def comment(id) 
        get "shuo/v2/statuses/comment/#{id}"
      end

      # 删除回复
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param id [String] 评论的id
      # @return [Boolean] 删除成功则返回true, 否则false
      # @example 删除 id 为2998638 的评论
      #   client.remove_comment('2998638')
      def remove_comment(id)
        begin
          delete "shuo/v2/statuses/comment/#{id}"
          return true
        rescue Douban::NotFound
          return false
        end
      end

      # 转播
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param id [String] 广播id
      # @return [Hashie::Mash] 广播列表
      # @example 转播id为1057472949的广播
      #   client.reshare('1057472949')
      def create_reshare(id)
        post "shuo/v2/statuses/#{id}/reshare"
      end
      alias :reshare :create_reshare

      # 获取最近转播的用户列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param id [String] 广播id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 查看id为1057472949的广播的转发者
      #   Douban.resharers('1057472949')
      def resharers(id, options={})
        get "shuo/v2/statuses/#{id}/reshare", options
      end

      # 删除转播
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param id [String] 广播的id
      # @return [Boolean] 删除成功则返回true, 否则false
      # @example 删除用户对id为1057472949的广播的转播
      #   client.remove_reshare('1057472949')
      def remove_reshare(id)
        begin
          delete "shuo/v2/statuses/#{id}/reshare"
          return true
        rescue Douban::NotFound
          return false
        end
      end
      alias :unreshare :remove_reshare

      # 赞一条广播
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param id [String] 广播的id
      # @return [Hashie::Mash] 对应的广播数据
      # @example 赞id为1057472949的广播
      #   client.like('1057472949')
      def like(id)
        post "shuo/v2/statuses/#{id}/like"
      end

      # 获取最近赞的用户列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param id [String] 广播的id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 获取id为1057472949的用户
      #   Douban.liked_users('1057472949')
      def liked_users(id, options={})
        get "shuo/v2/statuses/#{id}/like", options
      end

      # 取消赞一条广播
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param id [String] 广播的id
      # @return [Hashie::Mash] 对应的广播数据
      # @example 取消赞id为1057472949的广播
      #   client.unlike('1057472949')
      def unlike(id)
        delete "shuo/v2/statuses/#{id}/like"
      end

      # 获取用户关注列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @option options [Integer] :tag 该tag的id
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 获取2217855关注的用户
      #   Douban.following('2217855')
      def following(user_id=nil, options={})
        if user_id.nil?
          get "shuo/v2/users/#{get_user_id}/following", options
        else
          get "shuo/v2/users/#{user_id}/following", options
        end
      end

      # 获取用户关注者列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 获取2217855的关注者
      #   Douban.followers('2217855')
      def followers(user_id=nil, options={})
        if user_id.nil?
          get "shuo/v2/users/#{get_user_id}/followers", options
        else
          get "shuo/v2/users/#{user_id}/followers", options
        end
      end

      # 获取共同关注的用户列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated true
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 获取已认证用户和2012964的共同关注者
      #   client.follow_in_common('2012964')
      def follow_in_common(user_id, options={})
        get "shuo/v2/users/#{user_id}/follow_in_common", options
      end

      # 获取关注的人关注了该用户的列表
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated true
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 关注的人也关注2012964的用户
      #   client.following_followers_of('2012964')
      def following_followers_of(user_id=ni, options={})
        get "shuo/v2/users/#{user_id}/following_followers_of"
      end

      # 搜索用户
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param q [String] 搜索字符串
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 关注的人也关注2012964的用户
      #   Douban.shuo_search_users("小明")
      def shuo_search_users(q, options={})
        get "shuo/v2/users/search", options.merge(:q => q)
      end

      # block用户
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param user_id [String] 用户的数字id
      # @return [Boolean] block成功则返回true, 否则false
      # @example block id为2012964的用户
      #   client.block('2012964')
      def block(user_id)
        post("shuo/v2/users/#{user_id}/block")["r"] == 1
      end

      # follow一个用户
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param user_id [String] 用户的数字id
      # @return [Hashie::Mash] follow用户的信息
      # @example follow id为2012964的用户
      #   client.follow('2012964')
      def follow(user_id)
        post "shuo/v2/friendships/create", :source => client_id, :user_id => user_id
      end

      # 取消关注一个用户
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_w
      # @authenticated true
      # @param user_id [String] 用户的数字id
      # @return [Hashie::Mash] unfollow用户的信息
      # @example 取消关注 id为2012964的用户
      #   client.unfollow('2012964')
      def unfollow(user_id)
        post "shuo/v2/friendships/destroy", :source => client_id, :user_id => user_id
      end

      # 取消关注一个用户
      #
      # @see http://developers.douban.com/wiki/?title=shuo_v2
      # @scope shuo_basic_r
      # @authenticated false
      # @param source_id [String] 用户的数字id
      # @param target_id [String] 用户的数字id
      # @return [Hashie::Mash] 关系的信息
      # @example 获取 id 2217855 和 2012964 的用户关系
      #   client.friendship('2217855','2012964')
      def friendship(source_id, target_id)
        options = {:source_id => source_id, :target_id => target_id, :source => client_id}
        get "shuo/v2/friendships/show", options
      end
    end
  end
end
