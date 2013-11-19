#!/usr/bin/env ruby

# Corey Finley
# 19 November 2013
# This script will take arguments form the command line and catch problems.
# Process the DFA given by the first command line argument, and then print "accept" 
# or "reject" for each string in the [input]-strings.txt given by the second command 
# line argument.

require_relative "./boolop.rb"

# check for missing arguments
unless !ARGV[0].nil?
	puts "Usage: ruby my_dfa_simulator.rb [dfa_description] [second_dfa_desctiption]"
	puts "          [dfa_description]             text file decribing dfa for compliment"
	puts "          [second_dfa_desctiption]      second optional text file decribing dfa for intersection"
	exit
end

# get file name from command line if given the -i flag
@dfa_file = ARGV[0]
@dfa2_file = ARGV[1] if !ARGV[1].nil?

# give intersection if a second dfa is given
# give compliment if no second is given
if @dfa2_file
	@boolop = BoolOp.new([@dfa_file, @dfa2_file])
	@boolop.intersection.std_out
else
	@boolop = BoolOp.new([@dfa_file])
	@boolop.gen_compliment
	@boolop.dfa.std_out
end