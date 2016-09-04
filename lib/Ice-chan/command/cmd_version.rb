puts "Load: cmd_version.rb\n"
puts "++++++++++++++++++++++++++++++++++++++++\n"

def cmd_version?(status)
  text = status.text
  irtsn = status.in_reply_to_screen_name

  if irtsn == $cfg.screen_name && parser?(text, ["-v", "--version"])
    return true
  else
    return false
  end
end

def cmd_version(client, status)
  name = status.user.screen_name
  id = status.id
  text = status.text

  puts timestamp + "@" + name + " > " + text

  tweet = "@" + name + " " + $cfg.bot_name + ": " + $ver

  puts timestamp + "@" + $cfg.screen_name + " > " + tweet

  client.update(tweet, :in_reply_to_status_id => id)
end