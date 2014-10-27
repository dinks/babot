require 'babot/version'

require 'hipbot'
require 'giphy'

require 'babot/config'
require 'babot/plugins'
require 'babot/helpers'

Giphy::Configuration.configure do |config|
  config.version = GIPHY.version
  config.api_key = GIPHY.api_key
end

module Babot
  class MyBot < Hipbot::Bot
    COMMANDS = %w( ping chuck gif github compare whois insult memes meme quotes explain google image youtube translate )

    configure do |c|
      c.jid       = XMPP.jid
      c.password  = XMPP.password

      c.join = XMPP.rooms

      c.helpers = BabotHelpers

      # Wolfram
      Hipbot::Plugins::WolframAlpha.configure do |wc|
        wc.appid = WOLFRAM.api_key
      end
    end

    on(/^whoami$/) do
      reply(
        "You are #{sender}\n" +
        "JID: #{sender.id}\n" +
        "Mention: @#{sender.mention}\n"
      )
    end

    on(/^help$/) do
      reply "Use with #{COMMANDS.join(', ')}"
    end
  end
end
