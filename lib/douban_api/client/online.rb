# -*- encoding : utf-8 -*-
module Douban
  class Client
    # Douban api online onlines 
    # @see http://developers.douban.com/wiki/?title=online_v2
    module Online
      def online(id)
        response = get "v2/online/#{id}"
      end
      
      def online_participants(id)
        response = get "v2/online/#{id}/participants"
        response["users"]
      end
      
      def online_discussions(id)
        response = get "v2/online/#{id}/discussions"
        response["discussions"]
      end
      
      def onlines(options={})
        response = get "v2/onlines", options
        response["onlines"]
      end
      
      def create_online(title, options={})
        post "v2/onlines", options.merge(:title => title)
      end
      
      def update_online(id, options={})
        put "v2/online/#{id}", options
      end
      
      def remove_online(id)
        delete "v2/online/#{id}"
      end
      
      def participants_online(id)
        post "v2/online/#{id}/participants"
      end
      
      def unparticipants_online(id)
        post "v2/online/#{id}/participants"
      end
      
      def like_online(id)
        post "v2/online/#{id}/like"
      end
      
      def unline_online(id)
        delete "v2/online/#{id}/like"
      end
      
      def online_photos(id)
        response = get "v2/online/#{id}/photos"
        response["photos"]
      end
      
      def online_discussions(id)
        response = get "v2/online/#{id}/discussions"
        response["discussions"]
      end
      
      def upload_online_photo(id, options={})
        post "v2/online/#{id}/photos", options
      end
      
      
      def created_onlines(id)
        if id.nil?
          response = get "v2/online/user_created/#{get_user_id}"
        else
          response = get "v2/onlines/user_created/#{id}"
        end
        
        response["onlines"]
      end
      
      def participated_onlines(id=nil)
        if id.nil?
          response = get "v2/online/user_participated/#{get_user_id}"
        else
          response = get "v2/online/user_participated/#{id}"
        end
        
        response["onlines"]
      end
      
      def wished_onlines(id=nil)
        if id.nil?
          response = get "v2/online/user_wished/#{get_user_id}"
        else
          response = get "v2/online/user_wished/#{id}"
        end
        
        response["onlines"]
      end
      
      def onlines(loc_id, options={})
        response = get "v2/online/list", optins.merge(:loc => loc_id)
        response["onlines"]
      end
      
    end
  end
end
