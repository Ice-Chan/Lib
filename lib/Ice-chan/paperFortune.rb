puts "Load: paperFortune.rb"

def paperFortune?(status)
    text = status.text
    rep = status.in_reply_to_screen_name
    rt = status.retweet?

    if rep == $cfg.screen_name && text =~ /--fortune|--omikuji|おみくじ|くじ|みくじ|fortune|ﾌｫｰﾁｭｰﾝ/ && rt == false
	    return true
	else
	    return false
	end
end

def paperFortune(client, status)
    name = status.user.screen_name
    id = status.id
    text = status.text
    result = [ "大吉", "中吉", "小吉", "吉", "半吉", "末吉", 
              "末小吉", "凶", "小凶", "半凶", "末凶", "大凶" ]

    puts timestamp + "@" + name + " > " + text

    puts "Fortune Start."
    
    # result から Random に抽出
    fortune = result.sample

    client.update("@" + name + "今日の運勢 : " + fortune + "\n", :in_reply_to_status_id => id)
    puts timestamp + "@" + $cfg.screen_name + " > " + fortune
end