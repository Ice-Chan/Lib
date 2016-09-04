puts "Load: nowPlaying.rb"

require 'rubygems'
require 'net/http'
require 'uri'
require 'json'
require 'open-uri'
require 'win32ole'
require 'kconv'

#************************
# NowPlaying?
# Argument : status
# return : none
#************************
def nowPlaying?(status)
	text = status.text
	name = "Astrisk_"
	puts $cfg.admin

	if name != $cfg.screen_name && text =~ /Current|CurrentTrack|CurrentMusic|--current|--nowplaying|nowPlaying|なうぷれ|iTunes|あいちゅーん|なう|now|曲|music|再生|play|played/ 
	    return true
	else
	    return false
	end
end

#************************************
# NowPlaying
# Argument : client, status
# return : none
#************************************
def nowPlaying(client, status)
    name = status.user.screen_name
    id = status.id
    text = status.text

#Playing Track
	begin
		puts "[DEBUG]: Begin."
		itunes = WIN32OLE.new('iTunes.Application')
		track = itunes.CurrentTrack
	rescue
		puts "iTunes can't Open process."
		itunes.quit
	 	return 0
	end

#Created txt
	puts "[DEBUG]: Created txt."
	
	begin
		nowPlaying = "@" << name << "\n" << "#NowPlaying\n" << "#{track.Name.kconv(Kconv::UTF8, Kconv::SJIS)}" + " by " + "#{track.Artist.kconv(Kconv::UTF8, Kconv::SJIS)}" + "\n"
		playCount = "playCount: " << "#{track.PlayedCount}" << " 回目\n" << "#Ice-chan\n"
		res = nowPlaying + playCount
	rescue
    	puts "Error : nowPlaying"
    	client.update("Error : nowPlaying Exception.")
	end

#Favorite
	puts "[DEBUG]: Favorite."
    client.favorite(id)
    
#Post from Twitter  
	puts "[DEBUG]: Post from Twitter."
	client.update(Kconv.kconv(res, Kconv::UTF8), :in_reply_to_status_id => id)
	#client.update(Kconv.kconv(count,Kconv::UTF8), :in_reply_to_status_id => id)
	#media = File.open('C:/Users/K/Desktop/Ice-chan/lib/Ice-chan/Ast_Header.jpg')
    #client.update_with_media(Kconv.kconv(strNowPlaying,Kconv::UTF8), media)
    #media.close
    
	#client.update_with_media(Kconv.kconv(strNowPlaying,Kconv::UTF8), "../../frip.jpg/")
	#media = File.open("C:/Users/K/Desktop/Ice-chan/lib/Ice-chan/Ast_Header.jpg").read
    #client.update_with_media(Kconv.kconv(strNowPlaying,Kconv::UTF8), media)

#Write from Console
	puts "[DEBUG]: Console."
	print(Kconv.tosjis(res))
	puts "++++++++++++++++++++++++++++++++++++++++\n"
end

#************************************
# searchJacket
# Argument : client, status
# return : none
#************************************
def searchJacket
	
end
