module Douban
  # Wrapper for the Douban REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {TODO:doc_URL the Douban API Documentation}.
  # @see TODO:doc_url
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include Douban::Client::Utils

    include Douban::Client::Book
    include Douban::Client::User
    include Douban::Client::Movie
    include Douban::Client::Music
    include Douban::Client::Event
    include Douban::Client::Shuo
    include Douban::Client::Doumail
    include Douban::Client::Album
    include Douban::Client::Note
    include Douban::Client::Discussion
    include Douban::Client::Online
    include Douban::Client::Comment
    
  end
end