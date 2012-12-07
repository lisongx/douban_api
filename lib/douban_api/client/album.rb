# -*- encoding : utf-8 -*-
module Douban
  class Client
    # 豆瓣日记 API V2 http://developers.douban.com/wiki/?title=note_v2
    module Album
      def album(id)
        get "v2/album/#{id}"
      end
      
      def create_album(options={})
        post "v2/albums", options
      end
      
      def update_album(id, options={})
        put "v2/album/#{id}", options
      end
      
      def remove_album(id)
        delete "v2/album/#{id}"
      end
      
      def album_photos(id, options)
        response = get("v2/album/#{id}/photos", options)
        response["photos"]
      end
      
      def like_album(id)
        post "v2/album/#{id}/like"
      end
      
      def unline_album(id)
        delete "v2/album/#{id}/like"        
      end
      
      def albums(user_id, options)
        if user_id.nil?
          response = get("v2/album/user_created/#{get_user_id}", options)
        else
          response = get("v2/album/user_created/#{user_id}", options)
        end
        response["albums"]
      end
      
      def liked_albums(user_id, options)
        if user_id.nil?
          response = get("v2/album/user_liked/#{get_user_id}", options)
        else
          response = get("v2/album/user_liked/#{user_id}", options)
        end
        response["albums"]
      end
      
      def photo(id)
        get "v2/photo/#{id}"
      end
      
      def upload_photo(album_id, image_path, options={})
        file = Faraday::UploadIO.new(image_path, options[:content_type])
        post "v2/album/#{album_id}", options.merge(:image => file)
      end
      
      def update_photo(id, desc)
        put "v2/photo/#{id}", {:desc => desc}
      end
      
      def delete_photo(id)
        delete "v2/photo/#{id}"
      end
      
      def like_photo(id)
        post "v2/photo/#{id}/like"
      end
      
      def unlike_photo(id)
        delete "v2/photo/#{id}/like"
      end
      
      # 照片回复列表
      # @scope community_basic_photo
      def photo_comments(id, options={})
        comments('photo', id, options={})
      end
      
      # 回复照片
      # @scope community_advanced_photo
      def create_photo_comment(id, content)
        create_comment('photo', id, content)
      end

      # 获得照片单条回复
      # @scope community_basic_photo
      def photo_comment(photo_id, comment_id)
        comment('photo', photo_id, comment_id)
      end
      
      # 删除照片单条回复
      # @scope community_advanced_photo
      def remove_photo_comment(photo_id, comment_id)
        remove_comment('photo', photo_id, comment_id)
      end
    end
  end
end
