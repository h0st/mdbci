#!/usr/bin/env ruby

require 'json'
require 'fileutils'
require 'getoptlong'

require_relative 'core/help'
require_relative 'core/generators'


puts 'MariaDb CI CLI'

config_file = 'config.mdbci.rb'

#Reading options
opts = GetoptLong.new(
                     ['--help', '-h', GetoptLong::NO_ARGUMENT],
                     ['--config', '-c', GetoptLong::REQUIRED_ARGUMENT],
                     ['--platforms','-p', GetoptLong::NO_ARGUMENT]
)

opts.each do |opt,arg|
  case opt
    when '--platforms'
      puts boxes.keys
    when '--config'
      if arg == ''
        puts 'Using default config name \''+config_file+'\''
      else
        config_file = arg
      end
    when '--help'
      Help.display
    else
      puts 'Options are not supported'
  end
end

if ARGV[ARGV.length-1]!='up'
  puts 'Command (up) is required'
  Help.display
else
  boxes = JSON.parse(IO.read('boxes'))
  config = JSON.parse(IO.read(config_file))
  Generator.generate(config,boxes)
end


