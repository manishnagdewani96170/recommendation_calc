#!/bin/ruby
require File.expand_path('./get_recommended_score', File.dirname(__FILE__))
ARGV.each do|arg|
  if arg.include?('.txt')
    puts "Argument: #{arg}"
    GetRecommendedScore.new.manage_input_data(arg)
  else
    puts "Invalid Argument: #{arg}"
  end  
end

