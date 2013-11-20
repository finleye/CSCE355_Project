#!/usr/bin/env ruby

# Corey Finley
# 19 November 2013
# This script will take arguments form the command line and catch problems.
# Process the DFA given by the first command line argument, and then print "accept" 
# or "reject" for each string in the [input]-strings.txt given by the second command 
# line argument.

# require_relative "./dfa.rb"
require "#{File.dirname(__FILE__)}/dfa.rb"

# check for missing arguments
unless !ARGV[0].nil? && !ARGV[1].nil?
	puts "Usage: ruby my_dfa_simulator.rb [dfa_description] [input_file]"
	puts "          [dfa_description]    text file decribing dfa"
	puts "          [input_file]         text file of zero or more strings for processing"
	exit
end

# get file name from command line if given the -i flag
@dfa_file = ARGV[0]
@input_file = ARGV[1]

# create a DFA
@dfa = DFA.new(@dfa_file)

# process inputs
@dfa.process_inputs(@input_file)
