puts "Load: userlocal_ai.rb"

def userlocal_ai?(status)
  irtsn = status.in_reply_to_screen_name
  
  if irtsn == $cfg.screen_name
    return true
  else
    return false
  end
end

def userlocal_ai(client, status)
  name = status.user.screen_name
  id = status.id
  text = status.text
  
  puts timestamp + "@" + name + " > " + text
  
  text = parser(text, ["@mr9Alice"])
  
  uri = URI.parse(URI.escape("https://chatbot-api.userlocal.jp/api/chat?message=" + text + "&key=" + $cfg.userlocal_key))
  json = JSON.parse(Net::HTTP.get(uri))
  
  tweet = "@" + name + " " + json['result']

  sleep(tweet.length * 0.2)

  puts timestamp + "@" + $cfg.screen_name + " > " + tweet
  
  client.update(tweet, :in_reply_to_status_id => id)
end