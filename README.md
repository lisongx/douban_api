# douban_api

Simple Ruby wrapper for [Douban API V2](http://developers.douban.com/wiki/?title=api_v2)

这个项目仍在开发中，缺少文档和测试，欢迎贡献。
## Installation
    gem install douban_api


## Sample Sinatra App

完整的应用请到 https://github.com/seansay/douban_api_sinatra_example

Demo: http://doubanapi.notimportant.org/

    require 'rubygems'
    require 'sinatra'
    require 'haml'
    require 'douban_api'

    enable :sessions

    set :app_file, __FILE__
    set :root, File.dirname(__FILE__)
    set :views, 'views'
    set :public_folder, 'public'

    # 设置回调的URL和所需的scope(http://developers.douban.com/wiki/?title=oauth2)
    set :callback_url, "http://doubanapi.notimportant.org/connect"
    set :scope, "douban_basic_common,shuo_basic_r,shuo_basic_w"


    # 设置 apikey和secret，可在 http://developers.douban.com/apikey/ 处查看
    Douban.configure do |config|
      config.client_id = ENV['DOUBAN_API_KEY']
      config.client_secret = ENV['DOUBAN_API_SECRET']
    end


    get '/' do
      haml :index, :layout => :'layouts/application'
    end

    get '/login' do
      redirect Douban.authorize_url(:redirect_uri => settings.callback_url, :scope => settings.scope)
    end

    get '/connect' do
      response = Douban.get_access_token(params[:code], :redirect_uri => settings.callback_url)
      session[:access_token] = response.access_token
      session[:user_id] = response.douban_user_id
      redirect "/timeline"
    end

    get '/timeline' do
      @client = Douban.client(:access_token => session[:access_token], :user_id => session[:user_id])
      @statuses = @client.timeline
      haml :timeline, :layout => :'layouts/application'
    end

## API Useage Examples

    client = Douban.client(:access_token=>access_token, :user_id => user_id)

    # 获取已认证用户对音乐的所有标签
    client.user_music_tags

    => [{"count"=>166, "alt"=>"http://music.douban.com/tag/内地", "title"=>"内地"},
     {"count"=>155, "alt"=>"http://music.douban.com/tag/摇滚", "title"=>"摇滚"},
     {"count"=>139, "alt"=>"http://music.douban.com/tag/美国", "title"=>"美国"},
     {"count"=>127, "alt"=>"http://music.douban.com/tag/台湾", "title"=>"台湾"},
     {"count"=>109, "alt"=>"http://music.douban.com/tag/Pop", "title"=>"Pop"},
     {"count"=>105, "alt"=>"http://music.douban.com/tag/2011", "title"=>"2011"},
     {"count"=>100, "alt"=>"http://music.douban.com/tag/华语", "title"=>"华语"},
     {"count"=>97, "alt"=>"http://music.douban.com/tag/女声", "title"=>"女声"},
     {"count"=>87, "alt"=>"http://music.douban.com/tag/Rock", "title"=>"Rock"},
     {"count"=>83, "alt"=>"http://music.douban.com/tag/民谣", "title"=>"民谣"},
     {"count"=>80, "alt"=>"http://music.douban.com/tag/2010", "title"=>"2010"},
     {"count"=>77, "alt"=>"http://music.douban.com/tag/欧美", "title"=>"欧美"},
     {"count"=>73, "alt"=>"http://music.douban.com/tag/英国", "title"=>"英国"},
     {"count"=>73, "alt"=>"http://music.douban.com/tag/中国", "title"=>"中国"},
     {"count"=>65, "alt"=>"http://music.douban.com/tag/2012", "title"=>"2012"},
     {"count"=>60, "alt"=>"http://music.douban.com/tag/男声", "title"=>"男声"},
     {"count"=>55, "alt"=>"http://music.douban.com/tag/流行", "title"=>"流行"},
     {"count"=>52, "alt"=>"http://music.douban.com/tag/indie", "title"=>"indie"},
     {"count"=>52, "alt"=>"http://music.douban.com/tag/rock", "title"=>"rock"},
     {"count"=>48, "alt"=>"http://music.douban.com/tag/Indie", "title"=>"Indie"}]  
     
     # 已登录用户的豆邮收件箱
     client.inbox
     
     => [{"status"=>"R",
       "sender"=>
        {"avatar"=>
          "http://img3.douban.com/view/site/small/public/fc82eb2dcec6ed0.jpg",
         "alt"=>"http://site.douban.com/fuzz/",
         "id"=>"104427",
         "name"=>"THE FUZZ 法兹",
         "uid"=>"fuzz"},
       "title"=>"近期动向",
       "published"=>"2012-12-07 11:32:04",
       "content"=>
        "打扰各位，近期2场演出后我们将休整一段时间，开始专辑的准备和录制工作！\r\n\r\n2场演出分别是\r\n12.21 月亮钥匙 W 刺猬\r\n12.28 光圈 地下丝绒45周年致敬演出  "receiver"=>
        {"avatar"=>"http://img3.douban.com/icon/u2217855-34.jpg",
         "alt"=>"http://www.douban.com/people/xiaosong/",
         "id"=>"2217855",
         "name"=>"小松其实还没有",
         "uid"=>"xiaosong"},
       "id"=>"283060020"},
      {"status"=>"R",………………………………
     
      # 发送一条广播
      client.shuo("呵呵后")
      
      => {"category"=>nil,
       "reshared_count"=>0,
       "attachments"=>[],
       "entities"=>{"user_mentions"=>[], "topics"=>[], "urls"=>[]},
       "muted"=>false,
       "text"=>"呵呵后",
       "created_at"=>"2012-12-07 14:58:49",
       "title"=>"说：",
       "can_reply"=>1,
       "liked"=>false,
       "source"=>{"href"=>"", "title"=>"douReminder"},
       "like_count"=>0,
       "comments_count"=>0,
       "user"=>
        {"description"=>"",
         "small_avatar"=>"http://img3.douban.com/icon/u2217855-34.jpg",
         "uid"=>"xiaosong",
         "type"=>"user",
         "id"=>"2217855",
         "screen_name"=>"小松其实还没有"},
       "is_follow"=>false,
       "has_photo"=>true,
       "type"=>"text",
       "id"=>1059068526}
       
更多请查看[文档](http://rdoc.info/github/seansay/douban_api/master/frames) 或阅读 [源码](https://github.com/seansay/douban_api/tree/master/lib/douban_api/client)
     
## TODOs

* Test, test, test……
* 文档

## Copyright
This project a fork of [instagram-ruby-gem](https://github.com/Instagram/instagram-ruby-gem),  see [LICENSE](https://github.com/seansay/douban_api/blob/master/LICENSE.md) for details.