puts "Load: hey.rb"

def hey?(status)
  text = status.text
  name = status.user.screen_name
  rted = status.retweet?
  
  if name != $cfg.screen_name && text =~ /Hey|hey|ok|okey|come on|call|hello|へい｜へーい|やあ|ヘイ|ﾍｲ|おる|いる|おーけー|オーケー|ｵｰｹｰ|おっけー|オッケー|ｵｯｹｰ|おい|オイ|ｵｲ|かもん|カモン|ｶﾓﾝ|はろー|ハロー|ﾊﾛｰ|やっはろー/i && text =~ /にせはち|mr9Alice|にせはち()|あいすちゃん/i && rted == false
    return true
  else
    return false
  end
end

def hey(client, status)
  name = status.user.screen_name
  id = status.id
  text = status.text
  
  reply = ["どないしたねん？", "おっ？", "呼んだか？", "いるやで？", "にゃぴ", "にゃるーん", "がんばるぞいっ！", "ありえん良さみが深いｗ", "ぽきたｗ", "魔剤ンゴ！ｗ", "ぽきたw 魔剤ンゴ！？ ありえん良さみが深いw にせはちで優勝せえへん？ そり！そりすぎてソリになったw や、漏れのモタクと化したことのNASA✋  そりでわ、無限に練りをしまつ ぽやしみ〜"]
  
  puts timestamp + "@" + name + " > " + text
  
  tweet = "@" + name + " " + reply.sample

  puts timestamp + "@" + $cfg.screen_name + " > " + tweet

  client.favorite(id)
  
  client.update(tweet, :in_reply_to_status_id => id)
end
