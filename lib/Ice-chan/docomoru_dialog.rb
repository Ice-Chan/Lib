puts "Load: docomoru_dialog.rb"

def docomoru_dialog?(status)
  irtsn = status.in_reply_to_screen_name
  name = status.user.screen_name
  
  if irtsn == $cfg.screen_name && name != $cfg.screen_name
    return true
  else
    return false
  end
end

def docomoru_dialog(client, status, client_docomoru)
  name = status.user.screen_name
  id = status.id
  text = status.text
  
  puts timestamp + "@" + name + " > " + text
  
  text = parser(text, ["@mr9Alice"])
  
  res = client_docomoru.create_dialogue(text)
  
  # resの内容が質問であればuserlocal_aiへ切り替え
  if res.body['utt'].to_s =~ /すか(|？|。|\?)$|した(？|\?|か？)$|教えて(下|くだ)(さい|さい！)$|ます(？|\?)$|^ところで|^そういえば/
    puts "# @mr9Alice > " + res.body['utt'].to_s
    
    puts $cfg.bot_name + ": docomoru_dialog -> userlocal_ai"
    
    userlocal_ai(client, status)
  else
    tweet = "@" + name + " " + res.body['utt'].to_s

    sleep(tweet.length * 0.2)

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet
  
    client.update(tweet, :in_reply_to_status_id => id )
  end
end
