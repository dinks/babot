module Babot
  module Plugins
    class Giphy
      include Hipbot::Plugin

      desc 'Gif Help'
      on(/^gif$/) do
        reply 'gif (random | search | translate) (searchterm)'
      end

      desc 'Random Gif'
      on(/^gif random$/) do
        gif = ::Giphy.random
        reply(gif.image_url.to_s)
      end

      desc 'Random Gif with search'
      on(/^gif random (.+)$/) do |search|
        begin
          gif = ::Giphy.random(search)
          reply(gif.image_url.to_s)
        rescue
          reply("(firstworldproblems) Cant find anything with #{search}.. Sorry!")
        end
      end

      desc 'Search Gif'
      on(/^gif search (.+)$/) do |search|
        gif_data = ::Giphy.search(search, {
          limit: 10
        }).sample(1)
        begin
          reply(gif_data.first.fixed_width_image.url.to_s)
        rescue
          reply("(okay) Cant find anything with #{search}.. Sorry!")
        end
      end

      desc 'Translated Gif'
      on(/^gif translate (.+)$/) do |search|
        begin
          gif_data = ::Giphy.translate(search)
          reply(gif_data.first.fixed_width_image.url)
        rescue
          reply("(stare) Cant find anything with #{search}.. Sorry!")
        end
      end
    end
  end
end
