module Douban
  class Client
    # 豆瓣同城 V2 http://developers.douban.com/wiki/?title=event_v2
    module Event

      # 获取活动
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_get
      # @scope event_basic_r
      # @authenticated false
      # @param id [String] 活动的id
      # @return [Hashie::Mash] 活动信息
      # @example 获取 id为17790089 的活动信息
      #   Douban.event('17790089')
      def event(id)
        response = get "v2/event/#{id}"
      end

      # 获取参加活动的用户
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_participants
      # @scope event_basic_r
      # @authenticated false
      # @param id [String] 活动的id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 获取参与 id为17790089 活动的用户
      #   Douban.event_participants('17790089')
      def event_participants(id)
        response = get "v2/event/#{id}/participants"
        response["users"]
      end

      # 获取活动感兴趣的用户
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_wishers
      # @scope event_basic_r
      # @authenticated false
      # @param id [String] 活动的id
      # @return [Array<Hashie::Mash>] 用户列表
      # @example 获取对 id为17790089 活动感兴趣的用户
      #   Douban.event_wishers('17790089')
      def event_wishers(id)
        response = get "v2/event/#{id}/wishers"
        response["users"]
      end

      # 获取用户创建的活动
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_user_created
      # @scope event_basic_r
      # @authenticated false
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 活动列表
      # @example 获取 id为2217855 的用户创建的活动
      #   Douban.created_events('2217855')
      # @example 获取已认证的用户创建的活动
      #   client.created_events()
      def created_events(user_id=nil, options={})
        if user_id.nil?
          response = get("v2/event/user_created/#{get_user_id}", options)
        else
          response = get("v2/event/user_created/#{user_id}", options)
        end
        
        response["events"]
      end

      # 获取用户参加的活动
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_user_participated
      # @scope event_basic_r
      # @authenticated false
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 活动列表
      # @example 获取 id为2217855 的用户参加的活动
      #   Douban.participated_events('2217855')
      # @example 获取已认证的用户参加的活动
      #   client.participated_events()
      def participated_events(user_id=nil)
        if user_id.nil?
          response = get "v2/event/user_participated/#{get_user_id}"
        else
          response = get "v2/event/user_participated/#{user_id}"
        end
        
        response["events"]
      end

      # 获取用户参加的活动
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_user_wished
      # @scope event_basic_r
      # @authenticated false
      # @param user_id [String] 用户的数字id
      # @return [Array<Hashie::Mash>] 活动列表
      # @example 获取 id为2217855 的用户感兴趣的活动
      #   Douban.wished_events('2217855')
      # @example 获取已认证的用户感兴趣的活动
      #   client.wished_events()
      def wished_events(user_id=nil)
        if user_id.nil?
          response = get "v2/event/user_wished/#{get_user_id}"
        else
          response = get "v2/event/user_wished/#{user_id}"
        end
        
        response["events"]
      end

      # 获取活动列表
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_list
      # @scope event_basic_r
      # @authenticated false
      # @param loc_id [String] 城市id
      # @option options [String] :day_type 
      #   时间类型: future, week, weekend, today, tomorrow
      # @option options [String] :type
      #   活动类型: all,music, film, drama, commonweal, salon, exhibition, party, sports, travel, others
      # @return [Array<Hashie::Mash>] 活动列表
      # @example 查看北京地区的音乐活动
      #   Douban.events('108288', :type => "music")
      def events(loc_id, options={})
        response = get("v2/event/list", options.merge(:loc => loc_id))
        response["events"]
      end

      # 获取城市
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#loc_get
      # @scope event_basic_r
      # @authenticated false
      # @param loc_id [String] 城市id
      # @return [Hashie::Mash] 活动列表
      # @example 查看北京的信息
      #   Douban.loc('108288')
      def loc(id)
        response = get "v2/loc/#{id}"
      end

      # 获取城市列表
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#loc_list
      # @scope event_basic_r
      # @authenticated false
      # @return [Array<Hashie::Mash>] 城市列表
      # @example 城市列表
      #   Douban.loc_list
      def loc_list(options={})
        response = get("v2/loc/list", options)
        response["locs"]
      end

      # 参加活动
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_participate
      # @scope event_basic_w
      # @authenticated true
      # @param id [String] 活动的id
      # @option options [String] :participate_date
      #   参加时间: 时间格式：“％Y-％m-％d”，无此参数则时间待定
      # @return [Hashie::Mash] 活动信息
      # @example 参加 id为17717231 的活动
      #   client.participants_event('17717231')
      def participants_event(id, options={})
        post "v2/event/#{id}/participants", options
      end

      # 不参加活动
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_quit
      # @scope event_basic_w
      # @authenticated true
      # @param id [String] 活动的id
      # @return [Hashie::Mash] 活动信息
      # @example 取消参加 id为17717231 的活动
      #   client.unparticipants_event('17717231')
      def unparticipants_event(id)
        delete "v2/event/#{id}/participants"
      end
      
      # 对活动感兴趣
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_wish
      # @scope event_basic_w
      # @authenticated true
      # @param id [String] 活动的id
      # @return [Hashie::Mash] 活动信息
      # @example 对 id为17717231 的活动感兴趣
      #   client.wish_event('17717231')
      def wish_event(id)
        post "v2/event/#{id}/wishers"
      end

      # 对活动不感兴趣
      #
      # @see http://developers.douban.com/wiki/?title=event_v2#event_unwish
      # @scope event_basic_w
      # @authenticated true
      # @param id [String] 活动的id
      # @return [Hashie::Mash] 活动信息
      # @example 对 id为17717231 的活动不感兴趣
      #   client.wish_event('17717231')
      def unwish_event(id)
        delete "v2/event/#{id}/wishers"
      end
    end
  end
end
