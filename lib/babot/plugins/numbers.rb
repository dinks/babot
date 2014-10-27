module Hipbot
  module Plugins
    class Numbers
      include Hipbot::Plugin

      class NumbersTriviaGenerator
        URL = "http://numbersapi.com/"

        def date(month, day)
          get_trivia :date, "#{month}/#{day}"
        end

        def year year
          get_trivia :year, year
        end

        def math number
          get_trivia :math, number
        end

        def trivia number
          get_trivia :trivia, number
        end

        private

        def get_trivia(type, number = nil)
          number = number || 'random'

          open(URL + "#{number}/#{type}").read
        end
      end

      generator = NumbersTriviaGenerator.new

      desc "Random piece of number trivia for the specified number"
      on(/^trivia(?: (\d+))?$/) do |number|
        reply generator.trivia(number)
      end

      desc "Random piece of information about the specified number"
      on(/^trivia math(?: (\d+))?$/) do |number|
        reply generator.math(number)
      end

      desc "Random piece of information about the specified month and day"
      on(/^trivia date(?: (\d{1,2}) (\d{1,2}))?$/) do |month, day|
        reply generator.date(month, day)
      end

      desc "Random piece of information about the specified year"
      on(/^trivia year(?: (\d{4}))?$/) do |year|
        reply generator.year(year)
      end

      # desc 'random fact for login users'
      # on_presence do |status|
      #   month = rand(12).to_s
      #   day = rand(28).to_s

      #   case status
      #   when ''
      #     reply("Welcome, #{sender.name}! Did you know #{generator.date(month, day)}")
      #   end
      # end
    end
  end
end
