# -*- encoding : utf-8 -*-
module Douban
  class Client
    # 豆瓣日记 API V2 http://developers.douban.com/wiki/?title=note_v2
    module Note
      def create_note(options={})
        post "v2/notes", options
      end
      
      def notes(user_id=nil, format="text", options={})
        options.merge!(:format => format)
        
        if user_id.nil?
          response = get("v2/note/user_created/#{get_user_id}", options)
        else
          response = get("v2/note/user_created/#{user_id}", options)
        end
        
        response["notes"]
      end

      def liked_notes(user_id=nil, format="text", options={})
        options.merge!(:format => format)
        
        if user_id.nil?
          response = get("v2/note/user_liked/#{get_user_id}", options)
        else
          response = get("v2/note/user_liked/#{user_id}", options)
        end
        
        response["notes"]
      end
      
      def notes_guesses(user_id=nil, format="text", options={})
        options.merge!(:format => format)
        
        if user_id.nil?
          response = get("/v2/note/people_notes/#{get_user_id}/guesses", options)
        else
          response = get("v2/note/user_liked/#{user_id}", options)
        end
        
        response["notes"]
      end
      
      def note(id, format="text")
        options.merge!(:format => format)
        get "v2/note/#{id}", options
      end
      
      def create_note(options={})
        post "v2/notes", options
      end
      
      def like_note(id)
        post "v2/note/#{id}/like"
      end
      
      def unlike_note(id)
        delete "v2/note/#{id}/like"
      end
      
      def update_note(id, options={})
        put "v2/note/#{id}", options
      end
      
      def upload_photon_to_note(id, options)
        post "v2/note/#{id}", options
      end
      
      def remove_note(id)
        delete("v2/note/#{id}")["status"] == 200
      end
      
      def note_comments(id, options={})
        response = get("v2/note/#{id}/comments", options)
        response["comments"]
      end
      
      def create_note_comment(id, content)
        post "v2/note/#{id}/comments", {:content => content}
      end
      
      
      def note_comment(note_id, comment_id)
        get "v2/note/#{note_id}/comment/#{comment_id}"
      end
      
      def remove_note_comment(note_id, comment_id)
        delete "v2/note/#{note_id}/comment/#{comment_id}"
      end
    end
  end
end
