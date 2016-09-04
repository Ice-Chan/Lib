puts "Load: followme.rb"

def followme?(status)
  text = status.text
  name = status.in_reply_to_screen_name
  
  if name == $cfg.screen_name && text =~ /followme|ふぉろー|ﾌｫﾖｰ|ふぉろみー/
    return true
  else
    return false
  end
end

def followme(client, status)
  name = status.user.screen_name
  id = status.id
  text = status.text
  
  puts timestamp + "@" + name + " > " + text

  if client.friendship?($cfg.screen_name, name)
    tweet = "@" + name + " すでにフォローしています。"
  else
    client.follow(name)
    tweet = "@" + name + " フォローしました！"
  end

  puts timestamp + "@" + $cfg.screen_name + " > " + tweet

  client.update(tweet, :in_reply_to_status_id => id)
end