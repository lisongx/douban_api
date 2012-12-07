# -*- encoding : utf-8 -*-
module Douban
  class Client
    # 论坛API V2 http://developers.douban.com/wiki/?title=discussion_v2
    module Discussion
      def discussion(id)
        get "v2/discussion/#{id}"
      end
      
      def update_discussion(id, options={})
        put "v2/discussion/#{id}", options
      end
      
      def delete_discussion(id)
        delete "v2/discussion/#{id}"
      end
      
      def create_discussion(id ,options={})
        post "v2/target/#{id}/discussions", options
      end
      
      def discussions(id, options={})
        response = get("v2/target/#{id}/discussions", options)
        response["discussions"]
      end
      
      def discussion_comments(id, options={})
        comments('discussion', id, options={})
      end

      def create_discussion_comment(id, content)
        create_comment('discussion', id, content)
      end

      def discussion_comment(discussion_id, comment_id)
        comment('discussion', discussion_id, comment_id)
      end

      def remove_discussion_comment(discussion_id, comment_id)
        remove_comment('discussion', discussion_id, comment_id)
      end

    end
  end
end
