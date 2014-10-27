module Babot
  module Plugins
    class Alive
      include Hipbot::Plugin

      APP_URLS = {
        'home'      =>  'http://www.babbel.com/pulse',
        'lp'        =>  'http://lp.babbel.com/pulse',
        'accounts'  =>  'http://accounts.babbel.com/pulse',
        'my'        =>  'http://my.babbel.com/pulse'
      }.freeze

      desc 'ping a server'
      on(/^ping (.+)$/) do |app|
        if url = APP_URLS[app]
          reply("Checking #{app}!")
          get(url, ping: '1') do |response|
            if response.code == 200
              reply("(freddie) All good for #{app}!")
            else
              reply("(boom) #{app} is down!")
            end
          end
        else
          if app == 'help'
            reply 'Usage: ping (home |lp | accounts | my)'
          else
            reply("(fu) No app configured of that name!!!")
          end
        end
      end
    end
  end
end
