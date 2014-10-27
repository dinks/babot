require 'json'

class ChuckNorris
  BASE_URL = 'http://api.icndb.com/jokes/random'

  def initialize(json)
    @json = JSON.parse(json)
  end

  def joke
    if @json
      "(chucknorris) #{@json['value']['joke']}"
    else
      '(chucknorris) Chuck Norris does not joke!'
    end
  end
end

module Babot
  module Plugins
    class Chuck
      include Hipbot::Plugin

      desc 'chuck norris joke'
      on(/^chuck$/) do
        get(::ChuckNorris::BASE_URL) do |response|
          if response.code == 200
            reply ::ChuckNorris.new(response.body).joke
          else
            reply("(fu) Chuck Norris has left the building!")
          end
        end
      end
    end
  end
end
