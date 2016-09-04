puts "Load: timestamp.rb"

def timestamp
  return "[" + Time.now.strftime("%Y/%m/%d %H:%M:%S").to_s + "]"
end