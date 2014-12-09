require 'json'

class BabbelExcuse
  DEVELOPER_BASE_URL  = 'http://developerexcuses.com/'

  DEVELOPER_REGEXP  = /<a.*?>(.*?)<\/a>/

  DESIGNER_QUOTES = [
    "That wonâ€™t fit the grid.",
    "Thatâ€™s not in the wireframes.",
    "Thatâ€™s a developer thing.",
    "I didnâ€™t mock it up that way.",
    "The developer must have changed it.",
    "Did you try hitting refresh?",
    "No one uses IE anyway.",
    "Thatâ€™s not how I designed it.",
    "Thatâ€™s way too skeuomorphic.",
    "Thatâ€™s way too flat.",
    "Just put a long shadow on it.",
    "It wasnâ€™t designed for that kind of content.",
    "Josef MÃ¼ller-Brockmann.",
    "That must be a server thing.",
    "It only looks bad if itâ€™s not on Retina.",
    "Are you looking at it in IE or something?",
    "Thatâ€™s not a recognised design pattern.",
    "It wasnâ€™t designed to work with this content.",
    "The users will never notice that.",
    "The users might not notice it, but theyâ€™ll feel it.",
    "These brand guidelines are shit.",
    "You wouldnâ€™t get it, it's a design thing.",
    "Jony wouldnâ€™t do it like this.",
    "Thatâ€™s a dark pattern.",
    "I donâ€™t think thatâ€™s very user friendly.",
    "Thatâ€™s not what the research says.",
    "I didnâ€™t get a change request for that.",
    "No, that would break the vertical rhythm.",
    "Whyâ€™s this type so ugly? Did a developer do it?",
    "Because thatâ€™s not my design style.",
    "If the user canâ€™t figure this out, theyâ€™re an idiot.",
    "Ever heard of apostrophes?",
    "It looked fine in the mockups.",
    "Just put some gridlines on it.",
    "No, I didnâ€™t test it on Firefox. I donâ€™t install that trash on my Mac.",
    "If they donâ€™t have JavaScript turned on, itâ€™s their own damn fault.",
    "I donâ€™t care if they donâ€™t have a recent browser, this is 2013!",
    "Itâ€™s a responsive layout, of course it has widows."
  ]

  LOADABLE_EMITICONS = [
    '(dealwithit)',
    '(drevil)',
    '(dumb)',
    '(failed)',
    '(fuckyeah)',
    '(gates)',
    '(goodnews)',
    '(jobs)',
    '(nothingtodohere)',
    '(nextgendev)'
  ]

  def initialize(html, excuse)
    @html = html
    @excuse = excuse
  end

  def excuse
    emoticon = LOADABLE_EMITICONS.sample(1).first
    if @excuse == :developer
      if @html && m = DEVELOPER_REGEXP.match(@html)
        "#{emoticon} #{m[1]}"
      else
        "#{emoticon} Im just Lazy!"
      end
    else
      DESIGNER_QUOTES.sample(1).first
    end
  end
end

module Babot
  module Plugins
    class BabbelExcuse
      include Hipbot::Plugin

      desc 'developer excuse'
      on(/^developer_excuse$/) do
        get(::BabbelExcuse::DEVELOPER_BASE_URL) do |response|
          if response.code == 200
            reply ::BabbelExcuse.new(response.body, :developer).excuse
          else
            reply "(ohgodwhy) Im just Lazy!"
          end
        end
      end

      desc 'designer excuse'
      on(/^designer_excuse$/) do
        reply ::BabbelExcuse.new(response.body, :designer).excuse
      end
    end
  end
end
