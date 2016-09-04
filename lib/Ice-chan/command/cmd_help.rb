puts "Load: cmd_help.rb"

def cmd_help?(status)
  text = status.text
  name = status.in_reply_to_screen_name

  if name == $cfg.screen_name && parser?(text, ["-h", "--help"])
    return true
  else
    return false
  end
end

def cmd_help(client, status)
  name = status.user.screen_name
  id = status.id
  text = status.text

  puts timestamp + "@" + name + " > " + text

  t = [
      "@" + name + " " + $cfg.bot_name + ":\n[String]\n--followme\n\n--help, \n(1/3)",
      "@" + name + " " + $cfg.bot_name + ":\n--status, -s\n--update_name [Name], --name [Name], -n [Name]\n(2/3)",
      "@" + name + " " + $cfg.bot_name + ":\n--version, -v\n--weather [Location], -w [Location]\n, --nowPlaying\n, --fortune\n(3/3)"
  ]

  t.each do |tweet|
    puts timestamp + "@" + $cfg.screen_name + " > " + tweet

    client.update(tweet, :in_reply_to_status_id => id)
  end
end