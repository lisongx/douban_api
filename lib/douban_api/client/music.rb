module Douban
  class Client
    # 音乐Api V2 http://developers.douban.com/wiki/?title=music_v2
    module Music
      # 获取音乐信息
      #
      # @see http://developers.douban.com/wiki/?title=music_v2#get_music
      # @scope music_basic_r
      # @authenticated false
      # @param id [String] 音乐的id
      # @return [Hashie::Mash] 音乐信息
      # @example 获取 id为2243497 的音乐信息
      #   Douban.music('2243497')
      def music(id)
        response = get "v2/music/#{id}"
      end

      # 某个音乐中标记最多的标签
      #
      # @scope music_basic_r
      # @see http://developers.douban.com/wiki/?title=music_v2#get_music_tags
      # @authenticated false
      # @param id [String] 音乐的id
      # @return [Array<Hashie::Mash>] 标签的列表
      # @example 获取 id为2243497 的音乐的标记最多的标签
      #   Douban.music_tags("2243497")
      def music_tags(id, optins={})
        response = get "v2/music/#{id}/tags", options
        responses["tags"]
      end

      # 搜索音乐
      #
      # @scope music_basic_r
      # @see http://developers.douban.com/wiki/?title=music_v2#get_music_search
      # @authenticated false
      # @param q [String] 查询关键字
      # @return [Hashie::Mash] 音乐列表
      # @example 搜索音乐 LCD soundsystem 相关的音乐
      #   Douban.search_musics("LCD soundsystem")
      def search_music(q, options={})
        response = get "v2/music/search", options.merge(:q => q)
        response["musics"]
      end
      
      # 搜索音乐(通过标签)
      #
      # @scope music_basic_r
      # @see http://developers.douban.com/wiki/?title=music_v2#get_music_search
      # @authenticated false
      # @param tag [String] 查询的tag
      # @return [Hashie::Mash] 音乐列表
      # @example 搜索含有标签 post_punk 的音乐
      #   Douban.search_music_by_tag("post_punk")
      def search_music_by_tag(tag, options={})
        response = get "v2/music/search", options.merge(:tag => tag)
        response["musics"]
      end

      # 发表新评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=music_v2#post_music_review
      # @authenticated true
      # @param id [String] 音乐的id
      # @option options [String] :title 必传
      # @option options [String] :content 必传，且多于150字
      # @option options [Integer] :rating 非必传，数字1～5为合法值，其他信息默认为不打分     
      # @return [Hashie::Mash] 音乐评论信息
      # @example 给 id为2243497 的音乐添加评论
      #   client.create_music_review("2243497", {
      #     :title  => "用中枢神经在工地现场弹出印记",
      #     :content => "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈
      #      哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈
      #      哈哈哈哈哈哈哈哈哈哈哈哈...(省略一些哈)",
      #     :rating => 5
      #   })
      def create_music_review(id, options={})
        post "v2/music/reviews", options
      end

      # 修改评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=music_v2#put_music_review
      # @authenticated true
      # @param id [String] 评论的id
      # @option options [String] :title 必传
      # @option options [String] :content 必传，且多于150字
      # @option options [Integer] :rating 非必传，数字1～5为合法值，其他信息默认为不打分     
      # @return [Hashie::Mash] 音乐评论信息
      # @example 修改 id为1206396 的评论
      #   client.edit_music_review("1206396", {
      #     :title  => "用中枢神经在工地现场弹出印记",
      #     :content => "嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿
      #      嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿
      #      嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿...(省略一些嘿)",
      #     :rating => 5
      #   })
      def edit_music_review(id, options={})
        put "v2/music/reviews/#{id}", options
      end

      # 删除评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=music_v2#delete_music_review
      # @authenticated true
      # @param id [String] 音乐的id
      # @return [Boolean] 删除成功则返回true, 否则false
      # @example 删除 id为2243497 电影评论
      #   client.remove_music_review('2243497')
      def remove_music_review(id)
        begin
          delete "v2/music/review/#{id}"
          return true
        rescue Douban::NotFound
          return false
        end
      end

      
      # 用户对音乐的所有标签
      # 
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=music_v2#get_people_music_tags
      # @authenticated false
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 标签列表
      # @example 获取数字id为2217855的用户电影收藏的所有标签
      #   Douban.user_music_tags('2217855')      
      # @example 获取已认证用户的图书收藏的所有标签
      #   client.user_music_tags
      def user_music_tags(user_id=nil, options={})
        if user_id.nil?
          response = get("v2/music/user_tags/#{get_user_id}", options)
        else
          response = get("v2/music/user_tags/#{user_id}", options)
        end
        response["tags"]
      end
    end
  end
end
