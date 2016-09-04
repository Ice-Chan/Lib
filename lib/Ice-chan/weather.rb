puts "Load: weather.rb"

def weather?(status)
  text = status.text
  irtsn = status.in_reply_to_screen_name

  if irtsn == $cfg.screen_name && parser?(text, ["天気", "--weather", "weather", "-w"])
    return true
  else
    return false
  end
end

def weather(client, status)
  name = status.user.screen_name
  id = status.id
  text = status.text
  
  puts timestamp + "@" + name + " > " + text

  city = parser(text, ["天気", "weather", "--weather", "-w"]).gsub(/県$|市$|町$|村$/i, "")

  begin
    cityid = WeatherReport::Weather.request_cityid(city)
  rescue
    tweet = "@" + name + " 検索できませんでした。\n検索できる一覧です。\nhttp://weather.livedoor.com/forecast/rss/primary_area.xml\ne.g.) @.mr9Alice --weather 東京"

    puts timestamp + "@mr9Alice > " + tweet

    client.update(tweet, :in_reply_to_status_id => id)

    return 0
  end

  weather = WeatherReport::Weather.new(cityid)

  tweet = "@" + name + " " + city + "\n"
  tweet += "今日: " + weather.today.telop + "\n"
  tweet += "  傘: " + (weather.today.umbrella? ? "必要\n" : "不必要\n")
  tweet += "  最高気温: " + weather.today.temperature_max.to_s + "℃\n" if weather.today.temperature_max != nil
  tweet += "  最低気温: " + weather.today.temperature_min.to_s + "℃\n" if weather.today.temperature_min != nil
  tweet += "明日: " + weather.tomorrow.telop + "\n"
  tweet += "  傘: " + (weather.tomorrow.umbrella? ? "必要\n" : "不必要\n")
  tweet += "  最高気温: " + weather.tomorrow.temperature_max.to_s + "℃\n" if weather.tomorrow.temperature_max != nil
  tweet += "  最低気温: " + weather.tomorrow.temperature_min.to_s + "℃\n" if weather.tomorrow.temperature_min != nil

  puts timestamp + "@" + $cfg.screen_name + " > " + tweet
  
  client.update(tweet, :in_reply_to_status_id => id)
end
