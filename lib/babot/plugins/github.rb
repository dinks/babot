require 'json'

class GitHubDeSerializer
  BASE_URL = 'https://api.github.com'

  LOADABLE_EMITICONS = [
    '(yodawg)',
    '(yougotitdude)',
    '(success)',
    '(notbad)',
    '(mindblown)',
    '(iseewhatyoudidthere)',
    '(goodnews)',
    '(fuckyeah)',
    '(dumb)',
    '(content)',
    '(caruso)',
    '(bunny)',
    '(awyeah)',
    '(badass)',
    '(areyoukiddingme)'
  ]

  def self.url_for_user(name)
    "#{BASE_URL}/users/#{name}"
  end

  class User
    def initialize(data)
      @data = JSON.parse(data)
    end

    def name
      @data['name']
    end

    def from_location
      if l = @data['location']
        "from #{l}"
      end
    end

    def details
      emoticon = LOADABLE_EMITICONS.sample(1).first
      "#{emoticon} #{name} #{from_location} #{emoticon}"
    end
  end

  def self.user_from_json(json)
    User.new(json)
  end

end

module Babot
  module Plugins
    class Github
      include Hipbot::Plugin

      desc 'whois help'
      on(/^whois$/) do
        reply 'whois <username>'
      end

      desc 'whois user'
      on(/^whois (.+)/) do |name|
        get(GitHubDeSerializer.url_for_user(name)) do |response|
          if response.code == 200
            reply GitHubDeSerializer.user_from_json(response.body).details
          else
            reply "(megusta) I have no idea who that is!"
          end
        end
      end
    end
  end
end
