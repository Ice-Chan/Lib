puts "Load: streaming.rb"

def streaming(client, client_strm, client_docomoru, flag)
  client_strm.user do |status|
    if status.is_a?(Twitter::Tweet)
      if !flag #Ice-chan stop
        if cmd_admin?(status)
          flag = cmd_admin(client, status, flag)
        elsif cmd_status?(status)
          cmd_status(client, status, flag)
        end
        
      elsif flag #Ice-chan run.
        if cmd_admin?(status)
          flag = cmd_admin(client, status, flag)

        elsif cmd_help?(status)
          cmd_help(client, status)

        elsif cmd_status?(status)
          cmd_status(client, status, flag)

        elsif cmd_version?(status)
          cmd_version(client, status)

        elsif cmd_update_name?(status)
          cmd_update_name(client, status)

        elsif followme?(status)
          followme(client, status)

        elsif hey?(status)
          hey(client, status)

        elsif docomoru_knowledge?(status)
          docomoru_knowledge(client, status, client_docomoru)

        elsif weather?(status)
          weather(client, status)
         
        elsif nowPlaying?(status)
          nowPlaying(client, status)
        
        elsif paperFortune?(status)
			    paperFortune(client, status)
			
        elsif docomoru_dialog?(status)
          Thread.start do
            docomoru_dialog(client, status, client_docomoru)
          end
        end
      end
    end
  end
end