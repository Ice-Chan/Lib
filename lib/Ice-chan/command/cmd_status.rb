puts "Load: cmd_status.rb"

def cmd_status?(status)
  text = status.text
  name = status.in_reply_to_screen_name

  if name == $cfg.screen_name && parser?(text, ["-s", "--status"])
    return true
  else
    return false
  end
end

def cmd_status(client, status, flag)
  name = status.user.screen_name
  id = status.id
  text = status.text

  puts timestamp + "@" + name + " > " + text

  if flag
    tweet = "@" + name + " " + $cfg.bot_name + ": Running."
  elsif !flag
    tweet = "@" + name + " " + $cfg.bot_name + ": Stopped."
  end

  puts timestamp + "@" + $cfg.screen_name + " > " + tweet

  client.update(tweet, :in_reply_to_status_id => id)
end