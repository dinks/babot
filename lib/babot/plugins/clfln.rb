require 'open-uri'
require 'nokogiri'

class ClflnWeb
  BASE_URL = 'http://commitlogsfromlastnight.com'
end

module Babot
  module Plugins
    class Clfln
      include Hipbot::Plugin

      desc 'commit logs from last night'
      on(/^clfln$/) do
        begin
          doc = Nokogiri::HTML(open(ClflnWeb::BASE_URL))
          commit = doc.css("a.commit").sample
          reply "#{commit.content} #{commit[:href]}"
        rescue
          reply "The sh*t does not seem to work."
        end
      end
    end
  end
end
