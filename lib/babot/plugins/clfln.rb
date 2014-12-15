require 'open-uri'

class ClflnWeb
  BASE_URL = 'http://commitlogsfromlastnight.com'
end

module Babot
  module Plugins
    class Clfln
      include Hipbot::Plugin

      desc 'commit logs from last night'
      on(/^clfln$/) do
        doc = Nokogiri::HTML(open(ClflnWeb::BASE_URL))
        commits = @doc.css("a.commit").map(&:content)
        commits.sample
      end
    end
  end
end
