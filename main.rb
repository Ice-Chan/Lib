puts $ver = "ver1.4.2 : Ice-β"

require 'twitter'
require 'hashie'
require 'net/http'
require 'uri'
require 'json'
require 'open-uri'
require 'docomoru'
require 'weather-report'
require 'optparse'
require 'yaml'
require 'oauth'

# Load ./lib
Dir[File.expand_path('../lib', __FILE__) << '/*.rb'].each do |file|
  require file
end
# Load ./lib/Ice-chan
Dir[File.expand_path('../lib/Ice-chan', __FILE__) << '/*.rb'].each do |file|
  require file
end
# Load ./lib/Ice-chan/command
Dir[File.expand_path('../lib/Ice-chan/command', __FILE__) << '/*.rb'].each do |file|
  require file
end

# Load config.yml
$cfg = Hashie::Mash.load(File.expand_path('../config.yml', __FILE__))

# init
oauth = TwitterOauth.new
client = oauth.client
client_strm = oauth.client_strm
client_docomoru = Docomoru::Client.new(api_key: $cfg.docomo_api)
flag = true
$update_name_lock = false

#client.update_profile(name: $cfg.default_name)
client.update($ver + "\n" + Time.now.to_s)

# streaming
begin
  streaming(client, client_strm, client_docomoru, flag)
rescue
  retry
end
