# -*- encoding : utf-8 -*-
module Douban
  class Client
    # 电影Api V2 http://developers.douban.com/wiki/?title=movie_v2
    module Movie
      # 获取电影信息
      #
      # @see http://developers.douban.com/wiki/?title=movie_v2#get_movie
      # @scope movie_basic_r
      # @authenticated false
      # @param id [String] 电影的id
      # @return [Hashie::Mash] 电影信息
      # @example 获取 id为1054432 的电影信息
      #   Douban.movie('1054432')
      def movie(id)
        response = get "v2/movie/#{id}"
      end

      # 获取影人信息
      #
      # @see http://developers.douban.com/wiki/64/#get-celebrity
      # @scope movie_basic_r
      # @authenticated false
      # @param id [String] 影人的id
      # @return [Hashie::Mash] 影人信息
      # @example 获取 id为1054432 的影人信息
      #   Douban.celebrity('1054432')
      def celebrity(id)
        response = get "v2/movie/celebrity/#{id}"
      end

      # 获取影人作品
      #
      # @see http://developers.douban.com/wiki/64/#get-celebrity
      # @scope movie_basic_r
      # @authenticated false
      # @param id [String] 影人的id
      # @return [Array<Hashie::Mash>] 影人作品列表
      # @example 获取 id为1296987 的影人的作品列表
      #   Douban.celebrity_works('1054432')
      def celebrity_works(id)
        response = get "v2/movie/celebrity/#{id}/works"
        response["works"]
      end
      
      # 根据imdb号获取电影信息
      #
      # @scope movie_basic_r
      # @see http://developers.douban.com/wiki/?title=movie_v2#get_imdb_movie
      # @authenticated false
      # @param id [String] IMDb编号
      # @return [Hashie::Mash] 电影信息
      # @example 获取 IMDb编号为tt0075686 的图书信息
      #   Douban.imdb('tt0075686')
      def imdb(id)
        response = get "v2/movie/imdb/#{id}"
      end

      # 某个电影中标记最多的标签
      #
      # @scope movie_basic_r
      # @see http://developers.douban.com/wiki/?title=movie_v2#get_movie_tags
      # @authenticated false
      # @param id [String] 电影的id
      # @return [Array<Hashie::Mash>] 标签列表
      # @example 获取 电影id为1296987 的标签
      #   Douban.movie_tags('1296987')
      def movie_tags(id, optins={})
        response = get "v2/movie/#{id}/tags", options
        responses["tags"]
      end

      # 搜索电影
      #
      # @scope movie_basic_r
      # @see http://developers.douban.com/wiki/?title=movie_v2#get_movie_search
      # @authenticated false
      # @param q [String] 查询关键字
      # @return [Hashie::Mash] 电影列表
      # @example 搜索电影 伍迪·艾伦 相关的电影
      #   Douban.search_movies("伍迪·艾伦")
      def search_movies(q, options={})
        response = get "v2/movie/search", options.merge(:q => q)
        response["subjects"]
      end

      # 搜索电影(通过标签)
      #
      # @scope movie_basic_r
      # @see http://developers.douban.com/wiki/?title=movie_v2#get_movie_search
      # @authenticated false
      # @param tag [String] 查询的tag
      # @return [Hashie::Mash] 电影列表
      # @example 搜索含有标签 悬疑 的电影
      #   Douban.search_movies_by_tag("悬疑")
      def search_movies_by_tag(tag, options={})
        response = get "v2/movie/search", options.merge(:tag => tag)
        response["movies"]
      end

      # 发表新评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=movie_v2#post_movie_review
      # @authenticated true
      # @param id [String] 电影的id
      # @option options [String] :title 必传
      # @option options [String] :content 必传，且多于150字
      # @option options [Integer] :rating 非必传，数字1～5为合法值，其他信息默认为不打分     
      # @return [Hashie::Mash] 电影评论信息
      # @example 给 id为1296987 的电影添加评论
      #   client.create_movie_review("1296987", {
      #     :title  => "我们都需要鸡蛋",
      #     :content => "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈
      #      哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈
      #      哈哈哈哈哈哈哈哈哈哈哈哈...(省略一些哈)",
      #     :rating => 5
      #   })
      def create_movie_review(id, options={})
        post "v2/movie/reviews", options
      end

      # 修改评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=movie_v2#put_movie_review
      # @authenticated true
      # @param id [String] 评论的id
      # @option options [String] :title 必传
      # @option options [String] :content 必传，且多于150字
      # @option options [Integer] :rating 非必传，数字1～5为合法值，其他信息默认为不打分     
      # @return [Hashie::Mash] 电影评论信息
      # @example 修改id为1406334的评论
      #   client.edit_movie_review("1406334", {
      #     :title  => "我们读故事，看电影，不过是因为我们懦弱",
      #     :content => "嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻
      #      嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻
      #      嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻...(省略一些嘻)",
      #     :rating => 5
      #   })
      def edit_movie_review(id, options={})
        put "v2/movie/reviews/#{id}", options
      end

      # 删除评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=movie_v2#delete_movie_review
      # @authenticated true
      # @param id [String] 电影的id
      # @return [Boolean] 删除成功则返回true, 否则false
      # @example 删除 id为1406334 电影评论
      #   client.remove_movie_review('1406334')
      def remove_movie_review(id)
        begin
          delete "v2/movie/review/#{id}"
          return true
        rescue Douban::NotFound
          return false
        end
      end

      # 用户对电影的所有标签
      # 
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=movie_v2#get_people_movie_tags
      # @authenticated false
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 标签列表
      # @example 获取数字id为2217855的用户电影收藏的所有标签
      #   Douban.user_movie_tags('2217855')      
      # @example 获取已认证用户的图书收藏的所有标签
      #   client.user_movie_tags
      def user_movie_tags(user_id=nil, options={})
        if user_id.nil?
          response = get("v2/movie/user_tags/#{get_user_id}", options)
        else
          response = get("v2/movie/user_tags/#{user_id}", options)
        end
        
        response["tags"]
      end
    end
  end
end
