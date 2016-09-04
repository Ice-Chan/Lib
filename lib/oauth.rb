puts "Load: oauth.rb"

class TwitterOauth
  def initialize
    cfg = YAML.load_file(File.expand_path('../../config.yml', __FILE__))

    if cfg["at"] == nil || cfg["ats"] == nil
      consumer = OAuth::Consumer.new(cfg["ck"], cfg["cs"], :site => "https://api.twitter.com")

      request_token = consumer.get_request_token

      puts request_token.authorize_url
      print "PIN: "

      access_token = request_token.get_access_token(:oauth_verifier => gets.to_i)

      cfg["at"] = access_token.token
      cfg["ats"] = access_token.secret

      open(File.expand_path('../../config.yml', __FILE__), 'w') do |f|
        YAML.dump(cfg, f)
      end

      $cfg = Hashie::Mash.load(File.expand_path('../../config.yml', __FILE__))
    end
  end

  def client_strm
    client_strm = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = $cfg.ck
      config.consumer_secret     = $cfg.cs
      config.access_token        = $cfg.at
      config.access_token_secret = $cfg.ats
    end
    
    return client_strm
  end

  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = $cfg.ck
      config.consumer_secret     = $cfg.cs
      config.access_token        = $cfg.at
      config.access_token_secret = $cfg.ats
    end
    
    return client
  end
end