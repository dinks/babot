require 'json'

module Babot
  module Plugins
    class Quotes
      include Hipbot::Plugin

      BASE_URL = 'http://www.iheartquotes.com/api/v1'
      DEFAULT_PARAMS = {
        max_lines: 4,
        max_characters: 320,
        width: 225,
        height: 165
      }
      CATEGORIES = {
        'geek' => 'esr+humorix_misc+humorix_stories+joel_on_software+macintosh+math+mav_flame+osp_rules+paul_graham+prog_style+subversion',
        'general'=> '1811_dictionary_of_the_vulgar_tongue+codehappy+fortune+liberty+literature+misc+murphy+oneliners+riddles+rkba+shlomif+shlomif_fav+stephen_wright',
        'pop' => 'calvin+forrestgump+friends+futurama+holygrail+powerpuff+simon_garfunkel+simpsons_cbg+simpsons_chalkboard+simpsons_homer+simpsons_ralph+south_park+starwars+xfiles',
        'religious' => 'bible+contentions+osho',
        'scifi' => 'cryptonomicon+discworld+dune+hitchhiker'
      }.freeze

      desc 'quotes help'
      on(/^quotes$/) do
        reply 'quotes random'
        reply 'quotes category <category_name>'
      end

      desc 'random quotes'
      on(/^quotes random$/) do
        get("#{BASE_URL}/random", DEFAULT_PARAMS) do |response|
          if response.code == 200
            reply(response.body)
          else
            reply('(fu) Cant connect to quotes right now!')
          end
        end
      end

      desc 'quotes with category'
      on(/^quotes category (.+)$/) do |category|
        if source = CATEGORIES[category]
          get("#{BASE_URL}/random", DEFAULT_PARAMS.merge(source: source)) do |response|
            if response.code == 200
              reply(response.body)
            else
              reply('(fu) Cant connect to quotes right now!')
            end
          end
        else
          reply("Please choose from #{CATEGORIES.keys.join(', ')}")
        end
      end
    end
  end
end
