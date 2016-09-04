puts "Load: cmd_update_name.rb"

def cmd_update_name?(status)
  text = status.text
  name = status.in_reply_to_screen_name

  if name == $cfg.screen_name && parser?(text, ["-n", "--update_name", "--name", "update_name", "--lock_name", "--unlock_name"])
    return true
  else
    return false
  end
end

def cmd_update_name(client, status)
  name = status.user.screen_name
  id = status.id
  text = status.text

  puts timestamp + "@" + name + " > " + text

  if parser?(text, ["--lock_name"]) && !parser?(text, ["-n", "--update_name", "--name", "update_name"])
    if name == $cfg.admin || name == $cfg.screen_name
      $update_name_lock = true
      tweet = "@" + name + " " + $cfg.bot_name + ": update_name locked."
    else
      tweet = "@" + name + " Error: Permission denied."
    end

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet

    client.update(tweet, :in_reply_to_status_id => id)
  elsif parser?(text, ["--unlock_name"]) && !parser?(text, ["-n", "--update_name", "--name", "update_name"])
    if name == $cfg.admin || name == $cfg.screen_name
      $update_name_lock = false
      tweet = "@" + name + " " + $cfg.bot_name + ": update_name unlocked."
    else
      tweet = "@" + name + " Error: Permission denied."
    end

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet

    client.update(tweet, :in_reply_to_status_id => id)
  elsif !$update_name_lock && client.friendship?($cfg.screen_name, name) && client.friendship?(name, $cfg.screen_name) || name == $cfg.screen_name || name == $cfg.admin
    new_name = parser(text, ["update_name", "--name", "--update_name", "-n"])

    if new_name.length > 20
      tweet = "@" + name + " Error: 名前が長過ぎます。"
    #elsif new_name.length < 1
    #  client.update_profile(name: $cfg.default_name)

    #  tweet = "> @" + name + " " + $cfg.bot_name + ": 名前をデフォルトに変更しました。"
    else
      begin
        client.update_profile(name: new_name)

        client.retweet(id) if !status.user.protected?

        tweet = "> @" + name + " " + $cfg.bot_name + ": Rename is「" + new_name + "」."
      rescue
        #tweet = "@" + name + " update_name でエラーが起きてます。制作者は直ちに出てこいや。"
      end
    end

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet

    client.update(tweet, :in_reply_to_status_id => id)
  elsif $update_name_lock
    tweet = "@" + name + " Error: 名前はロックされています。"

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet

    client.update(tweet, :in_reply_to_status_id => id)
  else
    tweet = "@" + name + " Error: Permission denied.\nこの機能はF/F内のユーザのみ使用できます。"

    puts timestamp + "@" + $cfg.screen_name + " > " + tweet

    client.update(tweet, :in_reply_to_status_id => id)
  end
end
