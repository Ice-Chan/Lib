puts "Load: parser.rb"

# textの中にoptionが含まれていたらtrueを返す
def parser?(text, option)
  ret = false

  option.each do |opt|
    ret = true if text.split.index(opt) != nil
  end

  return ret
end

# textの中からoptionとoptionより前を消したものを返す
def parser(text, option)
  text = text.split

  catch :parse do
    text.each do |t|
      option.each do |opt|
        if t == opt
          text.slice!(0, text.index(opt) + 1)
          throw :parse
        end
      end
    end
  end
=begin
  option.each do |opt|
    text.slice!(0, text.index(opt)+1) if text.index(opt) != nil
  end
=end
  return text.join(" ")
end