require 'yaml'
require 'erb'

%w( xmpp giphy wolfram ).each do |name|
  file = "./config/#{name}.yml.erb"
  config = YAML.load(ERB.new(File.read(file)).result)[name]
  Kernel.const_set(name.upcase, OpenStruct.new(config))
end
