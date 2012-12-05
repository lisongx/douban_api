module Douban
  class Client
    # 图书Api V2 
    # @see http://developers.douban.com/wiki/?title=book_v2
    module Book

      # 获取图书信息
      #
      # @see http://developers.douban.com/wiki/?title=book_v2#get_book
      # @scope book_basic_r
      # @authenticated false
      # @param id [String] 图书的id
      # @return [Hashie::Mash] 图书信息
      # @example 获取 id为3821057 的图书信息
      #   Douban.book('3821057')
      def book(id)
        response = get "v2/book/#{id}"
      end

      # 根据isbn获取图书信息
      #
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_isbn_book
      # @authenticated false
      # @param id [String] 图书的id
      # @return [Hashie::Mash] 
      # @example 获取 ISBN为9787208083950 的图书信息
      #   Douban.isbn('9787208083950')
      def isbn(id)
        response = get "v2/book/isbn/#{id}"
      end

      # 通过关键字搜索图书
      #
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_book_search
      # @authenticated false
      # @param q [String] 查询关键字
      # @return [Hashie::Mash] 符合查询条件的图书列表
      # @example 搜索 的图书信息
      #   Douban.search_books("搏击俱乐部")
      def search_books(q, options={})
        response = get "v2/book/search", options.merge(:q => q)
        response["books"]
      end
      
      # 通过tag搜索图书
      #
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_book_search
      # @authenticated false
      # @param tag [String] 查询的tag
      # @return [Array<Hashie::Mash>] 符合查询条件的图书列表
      # @example 搜索tag包含"美国文学"的图书信息
      #   Douban.search_books_by_tag("美国文学")
      def search_books_by_tag(tag, options={})
        response = get "v2/book/search", options.merge(:tag => tag)
        response["books"]
      end

      # 某个图书中标记最多的标签, 最多返回前50个tag
      #
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_book_tags
      # @authenticated false
      # @param id [String] 图书的id
      # @return [Array<Hashie::Mash>] 标签的列表
      # @example 获取 id为3821057 的图书的标记最多的标签
      #   Douban.book_tags("3821057")
      def book_tags(id, optins={})
        response = get "v2/book/#{id}/tags", options
        responses["tags"]
      end

      # 获取用户对图书的所有标签
      # 
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_user_book_tags
      # @authenticated false
      # @param name [String] 用户uid或者数字id
      # @return [Array<Hashie::Mash>] 标签列表
      # @example 获取ahbei图书收藏的所有标签
      #   Douban.user_book_tags('ahbei')      
      # @example 获取已认证用户的图书收藏的所有标签
      #   client.user_book_tags
      def user_book_tags(name=nil, options={})
        if name.nil?
          response = get("v2/book/user/#{get_user_id}/tags", options)
        else
          response = get("v2/book/user/#{name}/tags", options)
        end
        
        response["tags"]
      end

      # 发表新评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=book_v2#post_book_review
      # @authenticated true
      # @param id [String] 图书的id
      # @option options [String] :title 必传
      # @option options [String] :content 必传，且多于150字
      # @option options [Integer] :rating 非必传，数字1～5为合法值，其他信息默认为不打分     
      # @return [Hashie::Mash] 图书评论Review信息
      # @example 给 id为3821057 的图书添加评论
      #   client.create_book_review("3821057", {
      #     :title  => "我们的萧条就是我们的生活",
      #     :content => "嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻
      #      嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻
      #      嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻...(省略一些嘻)",
      #     :rating => 5
      #   })
      def create_book_review(book_id, options={})
        post "v2/book/reviews", options.merge(:book => book_id)
      end
      
      # 修改评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=book_v2#put_book_review
      # @authenticated true
      # @param id [String] 评论的id
      # @option options [String] :title 必传
      # @option options [String] :content 必传，且多于150字
      # @option options [Integer] :rating 非必传，数字1～5为合法值，其他信息默认为不打分     
      # @return [Hashie::Mash] 图书评论Review信息
      # @example 修改id为5669920的评论
      #   client.edit_book_review("5669920", {
      #     :title  => "我们读故事，看电影，不过是因为我们懦弱",
      #     :content => "嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻
      #      嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻
      #      嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻...(省略一些嘻)",
      #     :rating => 5
      #   })
      def edit_book_review(id, options={})
        put "v2/book/reviews/#{id}", options
      end
      
      # 删除评论
      #
      # @scope douban_basic_common
      # @see http://developers.douban.com/wiki/?title=book_v2#delete_book_review
      # @authenticated true
      # @param id [String] 图书的id
      # @return [Boolean] 删除成功则返回true, 否则false
      # @example 删除 id为5669920 图书评论
      #   client.remove_book_review('5669920')
      def remove_book_review(id)
        begin
          delete "v2/book/review/#{id}"
          return true
        rescue Douban::NotFound
          return false
        end
      end

      # 获取某篇笔记的信息
      # 
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#delete_book_review
      # @authenticated true
      # @param id [String] 笔记的id
      # @option options [String] :format 
      #           返回content字段格式,选填（编辑伪标签格式：text,HTML格式：html）默认为text
      # @return [Hashie::Mash] 笔记的信息
      # @example 获取id为5963722的笔记的信息
      #   client.annotation('5963722')
      def annotation(id, options={})
        response = get "v2/book/annotation/#{id}", options
      end
      
      
      # 获取某本图书的所有笔记
      # 
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_book_annotations
      # @authenticated false
      # @param id [String] 图书的id
      # @option options [String] :format 
      #    返回content字段格式: 选填（编辑伪标签格式：text,HTML格式：html）默认为text
      # @option options [String] :order
      #    排序: 选填（最新笔记：collect, 按有用程度：rank, 按页码先后：page），默认为rank
      # @option options [Integer] :page
      #    按页码过滤: 选填
      # @return [Array<Hashie::Mash>] 笔记的列表
      # @example 获取 id为3821057的图书 的笔记
      #   client.book_annotations('3821057')
      def book_annotations(id, options={})
        response = get "v2/book/#{id}/annotations"
        response["annotations"]
      end
      
      # 用户给某本图书写笔记
      # 
      # @scope book_basic_w
      # @see http://developers.douban.com/wiki/?title=book_v2#post_book_annotation
      # @authenticated true
      # @param id [String] 图书的id
      # @param  options [String] :content 
      #    笔记内容: 必填，需多于15字
      # @option options [Integer] :page
      #    页码: 页码或章节名选填其一，最多6位正整数
      # @option options [String] :chapter
      #    章节名: 页码或章节名选填其一，最多100字
      # @option options [String] :privacy
      #    隐私设 选填： 值为'private'为设置成仅自己可见，其他默认为公开
      # @return [Hashie::Mash] 该笔记内容
      # @example 给id3821057的图书的第10页添加笔记
      #   client.create_book_annotations('3821057',{
      #     :content =>"据说是现在新浪共享上是有下载的",
      #     :page => 10
      #   })
      # TODO 支持图片
      def create_book_annotation(id, options={})
        post "v2/book/reviews", options
      end
      
      # 用户修改某篇笔记
      # 
      # @scope book_basic_w
      # @see http://developers.douban.com/wiki/?title=book_v2#put_annotation
      # @authenticated true
      # @param id [String] 图书的id
      # @param  options [String] :content 
      #    笔记内容: 必填，需多于15字
      # @option options [Integer] :page
      #    页码: 页码或章节名选填其一，最多6位正整数
      # @option options [String] :chapter
      #    章节名: 页码或章节名选填其一，最多100字
      # @option options [String] :privacy
      #    隐私设 选填： 值为'private'为设置成仅自己可见，其他默认为公开
      # @return [Hashie::Mash] 该笔记内容
      # @example 给id3821057的图书的第10页添加笔记
      #   client.create_book_annotations('3821057',{
      #     :content =>"据说是现在新浪共享上是有下载的",
      #     :page => 10
      #   })
      # TODO 支持图片
      def edit_book_annotation(id, options={})
        put "v2/book/annotation/#{id}", options
      end

      # 用户删除某篇笔记
      # 
      # @scope book_basic_w
      # @see http://developers.douban.com/wiki/?title=book_v2#delete_annotation
      # @authenticated true
      # @param id [String] 笔记的id
      # @return [Boolean] 删除成功则返回true, 否则false
      # @example 删除id为15143201的笔记 (只能删除用户自己的笔记)
      #   client.remove_book_annotation('15143201')
      def remove_book_annotation(id)
        begin
          delete "v2/book/annotation/#{id}"
          return true
        rescue Douban::NotFound
          return false
        end
      end
      
      # 获取某个用户的所有笔记
      # 
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_user_annotations
      # @authenticated false
      # @param name [String] 用户uid或者数字id
      # @return [Array<Hashie::Mash>] 该用户的笔记列表
      # @example 获取ahbei的所有笔记
      #   Douban.user_book_annotations('ahbei')      
      # @example 获取已认证用户的所有笔记
      #   client.user_book_annotations()
      def user_book_annotations(name=nil, options={})
        if name.nil?
          response = get("v2/book/user/#{get_user_id}/annotations", options)
        else
          response = get("v2/book/user/#{name}/annotations", options)
        end
        
        response["annotations"]
      end

      # 获取用户对某本图书的收藏信息
      # 
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_book_collection
      # @authenticated true
      # @param id [String] 图书的id
      # @return [Hashie::Mash] 用户对这本书的收藏信息
      # @example 获取已认证用户的对id为3821057的书的收藏信息
      #   client.user_book('3821057')
      def user_book(id)
        response = get "v2/book/#{id}/collection"
      end

      # 获取某个用户的所有图书收藏信息
      # 
      # @scope book_basic_r
      # @see http://developers.douban.com/wiki/?title=book_v2#get_user_collections
      # @authenticated false
      # @param name [String] 用户uid或者数字id
      # @option options [String] :status 
      #   收藏状态: 选填（想读：wish 在读：reading 读过：read）默认为所有状态
      # @option options [String] :tag 
      #   收藏标签: 选填
      # @option options [String] :from
      #   收藏更新时间过滤的起始时间    
      #   选填，格式为符合rfc3339的字符串，例如"2012-10-19T17:14:11"，其他信息默认为不传此项
      # @option options [String] :to
      #   收藏更新时间过滤的结束时间：同上
      # @option options [Integer] :rating
      #   星评: 选填，数字1～5为合法值，其他信息默认为不区分星评
      # @return [Array<Hashie::Mash>] 该用户的图书收藏列表
      # @example 获取ahbei的所有图书收藏
      #   Douban.books('ahbei')      
      # @example 获取已认证用户的所有图书收藏
      #   client.books()
      # TODO 可以允许options[:from]和options[:to]传入ruby日期对象
      def books(name=nil, options={})
        if user_id.nil?
          response = get("v2/book/user/#{get_user_id}/collections", options)
        else
          response = get("v2/book/user/#{name}/collections", options)
        end

        response["collections"]
      end

      # 获取某个用户的所有图书收藏信息
      # 
      # @scope book_basic_w
      # @see http://developers.douban.com/wiki/?title=book_v2#post_book_collection
      # @authenticated true
      # @param id [String] 图书的id
      # @param status [String] 收藏状态（想读：wish 在读：reading 读过：read）
      # @option options [String] :tag 
      #   收藏标签字符串: 选填，用空格分隔
      # @option options [String] :comment
      #   短评文本: 选填，最多350字
      # @option options [String] :privacy
      #   隐私设置: 选填，值为'private'为设置成仅自己可见，其他默认为公开
      # @option options [Integer] :rating
      #   星评: 选填，数字1～5为合法值，其他信息默认为不区分星评
      # @return [Hashie::Mash] 返回创建的图书收藏信息
      # @example 想读id为3821057的图书，并标记标签
      #   client.create_book_collection('3821057', 'wish', {
      #     :tag => "小说 美国 文学"
      #   })
      def create_book_collection(id, status, options={})
        post "v2/book/#{id}/collection", options.merge(:status => status)
      end

      # 获取某个用户的所有图书收藏信息
      # 
      # @scope book_basic_w
      # @see http://developers.douban.com/wiki/?title=book_v2#put_book_collection
      # @authenticated true
      # @param id [String] 图书的id
      # @param status [String] 收藏状态（想读：wish 在读：reading 读过：read）
      # @option options [String] :tag 
      #   收藏标签字符串: 选填，用空格分隔
      # @option options [String] :comment
      #   短评文本: 选填，最多350字
      # @option options [String] :privacy
      #   隐私设置: 选填，值为'private'为设置成仅自己可见，其他默认为公开
      # @option options [Integer] :rating
      #   星评: 选填，数字1～5为合法值，其他信息默认为不区分星评
      # @return [Hashie::Mash] 返回创建的图书收藏信息
      # @example 度过id为3821057的图书，并标记为5星
      #   client.change_book_collection('3821057', 'read', {
      #     :rating => 5
      #     :tag => "小说 美国 文学"
      #   })
      def change_book_collection(id, status, options={})
        post "v2/book/#{id}/collection", options.merge(:status => status)
      end

      # 用户删除某篇笔记
      # 
      # @scope book_basic_w
      # @see http://developers.douban.com/wiki/?title=book_v2#delete_book_collection
      # @authenticated true
      # @param id [String] 图书的id
      # @return [Boolean] 删除成功则返回true, 否则false
      # @example 删除用户对id为3821057的图书收藏
      #   client.remove_book_collection('3821057')
      def remove_book_collection(id)
        begin
          delete "v2/book/#{id}/collection"
          return true
        rescue Douban::NotFound
          return false
        end
      end
    end
  end
end
