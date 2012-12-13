# douban_api

Simple Ruby wrapper for [Douban API V2](http://developers.douban.com/wiki/?title=api_v2)

这个项目仍在开发中，缺少文档和测试，欢迎贡献。
## Installation
    gem install douban_api
    
## Examples

###  获取某部电影
    Douban.movie('1292000')

    <Hashie::Mash alt="http://movie.douban.com/movie/1292000" alt_title="搏击俱乐部 / 搏击会" attrs=#<Hashie::Mash cast=["爱德华·诺顿 Edward Norton", "布拉德·皮特 Brad Pitt", "海伦娜·邦汉·卡特 Helena Bonham Carter", "杰瑞德·莱托 Jared Leto"] country=["美国", "德国"] director=["大卫·芬奇 David Fincher"] language=["英语"] movie_duration=["139 分钟"] movie_type=["剧情", "悬疑", "惊悚"] pubdate=["1999-10-15"] title=["Fight Club"] writer=["恰克·帕拉尼克 Chuck Palahniuk", "Jim Uhls"] year=["1999"]> author=[#<Hashie::Mash name="大卫·芬奇 David Fincher">] collection_link="http://api.douban.com/collection/218762015" id="http://api.douban.com/movie/1292000" image="http://img3.douban.com/spic/s1447851.jpg" mobile_link="http://m.douban.com/movie/subject/1292000/" rating=#<Hashie::Mash average="9.1" max=10 min=0 numRaters=200291> summary="杰克（爱德华•诺顿 饰）是一个大汽车公司的职员，患有严重的失眠症，对周围的一切充满危机和憎恨。\n一个偶然的机会，杰克遇上了卖肥皂的商人泰勒（布拉德•皮特），一个浑身充满叛逆、残酷和暴烈的痞子英雄，并因为自己公寓失火而住进了泰勒破旧不堪的家中。两人因缘际会地成为了好朋友，并创立了“搏击俱乐部”：一个让人们不戴护具而徒手搏击，宗旨在于发泄情绪的地下组织。\n俱乐部吸引了越来越多的人，逐渐发展成为一个全国性的地下组织，而泰勒也以自己个人的魅力，吸引着那些盲目的信徒。俱乐部的成员们到处滋事打架、大肆破坏，泰勒本人的行为也越来越疯狂。\n杰克对于“搏击俱乐部”的现况及泰勒的行为越来越无法忍受，和泰勒发生争执，泰勒离开了他。然而，杰克发现，他走到何处都无法摆脱泰勒的影子，他开始思考：我到底是谁？" tags=[#<Hashie::Mash count=29736 name="美国">, #<Hashie::Mash count=27727 name="心理">, #<Hashie::Mash count=22910 name="暴力">, #<Hashie::Mash count=20650 name="经典">, #<Hashie::Mash count=18032 name="悬疑">, #<Hashie::Mash count=12505 name="剧情">, #<Hashie::Mash count=9023 name="黑色">, #<Hashie::Mash count=5578 name="犯罪">] title="Fight Club">
    
    
## Copyright
This project a fork of [instagram-ruby-gem](https://github.com/Instagram/instagram-ruby-gem),  see [LICENSE](https://github.com/seansay/douban_api/blob/master/LICENSE.md) for details.