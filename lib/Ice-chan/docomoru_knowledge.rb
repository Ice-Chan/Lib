puts "Load: docomoru_knowledge.rb"

def docomoru_knowledge?(status)
  text = status.text
  irtsn = status.in_reply_to_screen_name
  
  if irtsn == $cfg.screen_name && parser?(text, ["質問", "-q", "--question"])
    return true
  else
    return false
  end
end

def docomoru_knowledge(client, status, client_docomoru)
  name = status.user.screen_name
  id = status.id
  text = status.text
  
  puts timestamp + "@" + name + " > " + text
  
  text = parser(text, ["質問", "-q", "--question"])
  
  res = client_docomoru.create_knowledge(text)
  
  tweet = "@" + name + " " + res.body['message']['textForDisplay'].to_s
  
  if res.body['message']['textForDisplay'] =~ /Wikipedia/i
    tweet = tweet + " " + res.body['answers'][0]['linkUrl'].to_s
  end

  puts timestamp + "@" + $cfg.screen_name + " > " + tweet
  
  client.update(tweet, :in_reply_to_status_id => id)
end