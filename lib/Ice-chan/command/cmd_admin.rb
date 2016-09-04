# coding:utf-8

puts "Load: cmd_admin.rb"

def cmd_admin?(status)
  text = status.text
  name = status.in_reply_to_screen_name

  if name == $cfg.screen_name && parser?(text, ["--start", "--stop", "--exit"])
    return true
  else
    return false
  end
end

def cmd_admin(client, status, flag)
  name = status.user.screen_name
  id = status.id
  text = status.text
  
  puts timestamp + "@" + name + " > " + text
  
  if name != $cfg.admin && name != $cfg.screen_name
    tweet = "@" + name + " " + $cfg.bot_name + ": Permission denied."

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet
    
    client.update(tweet, :in_reply_to_status_id => id)
    
    return flag
  end
  
  if text =~ /stop/i
    if flag
      tweet = "@" + name + " " + $cfg.bot_name + ": Stopped."
    
      puts timestamp + "@" + $cfg.screen_name + " > " + tweet
    
      client.update(tweet, :in_reply_to_status_id => id)
    
      return false
    elsif !flag
      tweet = "@" + name + " " + $cfg.bot_name + ": Already Stopped."

      puts timestamp + "@" + $cfg.screen_name + " > " + tweet
    
      client.update(tweet, :in_reply_to_status_id => id)
      
      return flag
    end
  elsif text =~ /start/i
    if !flag
      tweet = "@" + name + " " + $cfg.bot_name + ": Starting."

      puts timestamp + "@" + $cfg.screen_name + " > " + tweet
    
      client.update(tweet, :in_reply_to_status_id => id)
    
      return true
    elsif flag
      tweet = "@" + name + " " + $cfg.bot_name + ": Already Running."

      puts timestamp + "@" + $cfg.screen_name + " > " + tweet
    
      client.update(tweet, :in_reply_to_status_id => id)
      
      return flag
    end
  elsif text =~ /exit/i
    tweet = "@" + name + " " + $cfg.bot_name + " : Bye(='3').\n"

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet
    
    client.update(tweet, :in_reply_to_status_id => id)

    sleep(1)

    exit(0)
  end
end
