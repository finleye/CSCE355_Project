# Corey Finley
# 18 November 2013
# dfs_sim.rb

# require_relative "./file_reader.rb"
require "#{File.dirname(__FILE__)}/file_reader.rb"

class DFAArgumentError < ArgumentError; end

class DFA
	attr_accessor :reader, :num_states, :accepting_states, :alphabet, :transitions, :states

	# initialize and object, by running methods below
	def initialize(file)
		@reader = FileReader.new(file)
		raise DFAArgumentError, "Reader found no contents in file" if @reader.contents.nil?
		@num_states = self.count_states
		@states = self.get_states
		@accepting_states = self.find_accepting
		@alphabet = self.find_alpha
		@transitions = self.build_transitions
	end

	# get states count from from line 0
	def count_states
		return self.reader.contents[0].split("Number of states: ")[1].strip.to_i
	end

	# build an array of states i.e. [0,1,2]
	def get_states
		states = Array.new
		for i in 0..self.num_states-1
			states << i
		end
		return states
	end

	# build an array of accepting states from line 1
	def find_accepting
		states =  self.reader.contents[1].split("Accepting states: ")[1].strip.split(' ')
		rtn = Array.new
		states.each do |s|
			rtn << s.to_i
		end
		return rtn
	end

	# build an array of the alphabet from line 2
	def find_alpha
		return self.reader.contents[2].split("Alphabet: ")[1].split('')
	end

	# build the tranitions table from line 3, to the end
	def build_transitions
		table_text = self.reader.contents[3..self.reader.contents.count]
		table_hash = Hash.new

		table_text.each do |row|
			row.split(' ').each_with_index do |state, i|
				table_hash[i] = table_hash[i] << state.to_i unless table_hash[i].nil?
				table_hash[i] ||= Array.new << state.to_i
			end
		end

		return table_hash
	end

	# use the tranistions table to return the next state given an input character, and the current state
	def next_state(input, current_state)
		alpha_index = self.alphabet.index(input)
		# puts alpha_index.inspect
		return self.transitions[alpha_index][current_state] if alpha_index
	end

	# use next_state to iterate over an input string and return true or false if the final state
	# is included in the accepting states
	def valid_string?(input)
		state = 0
		trace = ""
		for i in 0..input.length-1
			out = "\"#{input[i..i]}\"|#{state}"
			state = next_state(input[i..i], state)
			out += " => #{state} "
			# puts out
		end

		# puts "\ntrace: #{trace}"
		# puts "\naccepting states: #{self.accepting_states}"
		# puts "\nfinal state: #{state}"

		return self.accepting_states.include?(state)
	end

	# use file_reader.rb to process an input file of strings and find if the string is accepting or rejecting
	def process_inputs(file)
		input_file = FileReader.new(file)
		puts "\n"

		input_file.contents.each_with_index do |test_string, i|
			output = "accept" if self.valid_string?(test_string)
			output ||= "reject"

			puts output
		end
	end

	# print the DFA's information to a file
	def to_file(filename_append)
		output = File.new("#{self.reader.file_name.split('.txt')[0]}#{filename_append}.txt", "w+")
		output << "Number of states: #{self.num_states}\n"
		output << "Accepting states: #{self.accepting_states.join(' ')}\n"
		output << "Alphabet: #{self.alphabet.join('')}\n"
		self.transitions.each do |k, v|
			output << "#{v.join(' ')}\n"
		end
		output.close
	end

	# print the DFA's information to standard output
	def std_out
		puts "Number of states: #{self.num_states}\n"
		puts "Accepting states: #{self.accepting_states.join(' ')}\n"
		puts "Alphabet: #{self.alphabet.join('')}\n"
		for i in 0..self.num_states-1
			out = ""
			self.transitions.each do |k, v|
				out +=  "#{v[i]} "
			end
			out.chomp(" ")
			puts out
		end
	end
end
