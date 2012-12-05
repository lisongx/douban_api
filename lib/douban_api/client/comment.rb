module Douban
  class Client
    # 回复Api V2 
    # @see http://developers.douban.com/wiki/?title=comment_v2
    module Comment
      private 
      # 获取回复列表
      # @see http://developers.douban.com/wiki/?title=comment_v2#list
      def comments(target, id, options={})
        response = get("v2/#{target}/#{id}/comments", options)
        response["comments"]
      end

      # 新发讨论
      # @see http://developers.douban.com/wiki/?title=comment_v2#new
      def create_comment(target, id, content)
        post "v2/#{target}/#{id}/comments", {:content => content}
      end

      # 获取单条回复
      # @see http://developers.douban.com/wiki/?title=comment_v2#get
      def comment(target, target_id, comment_id)
        get "v2/#{target}/#{target_id}/comment/#{comment_id}"
      end
      
      # 删除回复
      # @see http://developers.douban.com/wiki/?title=comment_v2#delete
      def remove_comment(target, target_id, comment_id)
        delete("v2/#{target}/#{target_id}/comment/#{comment_id}")[:status] == 200
      end
    end
  end
end
