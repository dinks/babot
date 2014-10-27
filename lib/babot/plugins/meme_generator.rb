module Babot
  module Plugins
    class MemeGenerator
      include Hipbot::Plugin

      desc 'list available memes to generate'
      on(/^memes/) do
        reply("Choose from #{Generator.memes.keys.sort.join(', ')}")
      end

      desc 'generates new meme eg. `meme courage_wolf Generate all the memes!`'
      on(/^meme (\w+)\s*(.*)/) do |meme, text|
        generator = Generator.new(meme, text)
        query = {
          u: generator.image_url,
          t1: generator.upper_text,
          t2: generator.lower_text,
          t1x: '',
          t1y: '',
          t1w: '',
          t1h: '',
          t2x: '',
          t2y: '',
          t2w: '',
          t2h: ''
        }
        encoded_query = query.respond_to?(:to_query) ? query.to_query : URI.encode_www_form(query)
        image_url = "http://v1.memecaptain.com/g?#{encoded_query}"
        open(image_url) { |f|
          response = JSON.parse(f.read)
          reply(response['imageUrl'])
        }
      end

      class Generator
        attr_reader :upper_text, :lower_text, :meme
        def initialize(meme, text)
          @meme = meme
          assign_texts(text)
        end

        def image_url
          meme_name = self.class.memes.fetch(meme.to_s)
          "http://v1.memecaptain.com/#{meme_name}"
        end

        private

        def assign_texts(text)
          quotes_regexp = /"(.*)"\s+"(.*)"/
          matches = text.match(quotes_regexp)
          if matches
            assign_upper_and_lower_texts(matches[1], matches[2])
          else
            middle = text.length / 2
            middle += 1 while !(text[middle].nil? || text[middle] =~ /\s/)
            assign_upper_and_lower_texts(text[0..middle], text[middle+1..-1])
          end
        end

        def assign_upper_and_lower_texts(upper_text, lower_text)
          @upper_text = upper_text.to_s.strip
          @lower_text = lower_text.to_s.strip
        end

        def self.memes
          {

            'aliens' => 'aliens.jpg',
            'all_the_things' => 'all_the_things.jpg',
            'all_the_things_sad' => 'all_the_things2.jpg',
            'annoying_facebook_girl' => 'annoying_facebook_girl.jpg',
            'aw_yeah' => 'aw_yeah.png',
            'bad_joke_eel' => 'bad_joke_eel.jpg',
            'bad_luck_brian' => 'bad_luck_brian.jpg',
            'bad_time' => 'bad_time.jpg',
            'bear_grylls' => 'bear_grylls.jpg',
            'boromir' => 'boromir.jpg',
            'business_cat' => 'business_cat.jpg',
            'conspiracy_keanu' => 'conspiracy_keanu.jpg',
            'cool_story_bro' => 'cool_story_bro.jpg',
            'courage_wolf' => 'courage_wolf.jpg',
            'dwight_schrute' => 'dwight_schrute.jpg',
            'first_world_problems' => 'first_world_problems.jpg',
            'feel_bad' => 'you_should_feel_bad.jpg',
            'fry' => 'fry.png',
            'good_guy_greg' => 'good_guy_greg.jpg',
            'grandma' => 'grandma.jpg',
            'insanity_wolf' => 'insanity_wolf.jpg',
            'internet_husband' => 'internet_husband.jpg',
            'internet_kid' => 'first_day_on_the_internet_kid.jpg',
            'joseph_ducreux' => 'joseph_ducreux.jpg',
            'viking' => 'laundry_room_viking.jpg',
            'me_gusta' => 'me_gusta.png',
            'megaman' => 'megaman_derp.jpg',
            'most_interesting' => 'most_interesting.jpg',
            'ned_stark' => 'ned_stark.jpg',
            'neil_degrasse_tyson' => 'neil_degrasse_tyson.png',
            'not_bad' => 'not_bad.png',
            'ok' => 'ok.png',
            'paranoid_parrot' => 'paranoid_parrot.jpg',
            'patrick' => 'patrick.jpg',
            'philosoraptor' => 'philosoraptor.jpg',
            'rage' => 'rage.png',
            'ron_swanson' => 'ron_swanson.jpg',
            'sap' => 'sap.jpg',
            'scumbag_steve' => 'scumbag_steve.jpg',
            'seriously' => 'seriously.png',
            'slowpoke' => 'slowpoke.jpg',
            'socially_awesome_awkward_penguin' => 'socially_awesome_awkward_penguin.jpg',
            'success_kid' => 'success_kid.jpg',
            'the_more_you_know' => 'the_more_you_know.jpg',
            'ti_duck' => 'ti_duck.jpg',
            'too_damn_high' => 'too_damn_high.jpg',
            'town_crier' => 'town_crier.jpg',
            'troll_face' => 'troll_face.jpg',
            'troll_hunter' => 'troll_hunter.jpg',
            'trolldad' => 'trolldad.png',
            'trolldad_dancing' => 'trolldad_dancing.png',
            'tyler_durden' => 'tyler_durden.jpg',
            'walter' => 'walter.jpg',
            'wonka' => 'wonka.jpg',
            'yo_dawg' => 'xzibit.jpg',
            'y_u_no' => 'y_u_no.jpg',
            'yao_ming' => 'yao_ming.jpg'
          }
        end
      end
    end
  end
end
