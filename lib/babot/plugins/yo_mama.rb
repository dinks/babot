require 'json'

class YoMama
  BASE_URL = 'http://api.yomomma.info/'

  LOADABLE_EMITICONS = [
    '(joffrey)',
    '(joffrey)',
    '(badjokeeel)'
  ]

  def initialize(json)
    @json = JSON.parse(json) rescue nil
  end

  def joke
    emoticon = LOADABLE_EMITICONS.sample(1).first
    if @json
      "#{emoticon} #{@json['joke']}"
    else
      "#{emoticon} Yo Mama is good. So no joke for you!"
    end
  end
end

module Babot
  module Plugins
    class YoMama
      include Hipbot::Plugin

      desc 'yo mama jokes'
      on(/^yomama$/) do
        get(::YoMama::BASE_URL) do |response|
          if response.code == 200
            if message.mentions.empty?
              reply ::YoMama.new(response.body).joke
            else
              message.mentions.each do |mention|
                reply "#{mention} #{::YoMama.new(response.body).joke}"
              end
            end
          else
            reply "(ohgodwhy) Yo Mama is good. So no joke for you!"
          end
        end
      end
    end
  end
end
