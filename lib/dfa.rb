# Corey Finley
# 18 November 2013
# dfs_sim.rb

require_relative "./file_reader.rb"

class DFAArgumentError < ArgumentError; end

class DFA
	attr_accessor :reader, :num_states, :accepting_states, :alphabet, :transitions, :states

	def initialize(file)
		@reader = FileReader.new(file)
		raise DFAArgumentError, "Reader found no contents in file" if @reader.contents.nil?
		@num_states = self.count_states
		@states = self.get_states
		@accepting_states = self.find_accepting
		@alphabet = self.find_alpha
		@transitions = self.build_transitions
	end

	def count_states
		return self.reader.contents[0].split(':')[1].strip.to_i
	end

	def get_states
		states = Array.new
		for i in 0..self.num_states-1
			states << i
		end
		return states
	end

	def find_accepting
		states =  self.reader.contents[1].split(':')[1].strip.split(' ')
		rtn = Array.new
		states.each do |s|
			rtn << s.to_i
		end
		return rtn
	end

	def find_alpha
		return self.reader.contents[2].split(':')[1].strip.split('')
	end

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

	def next_state(input, current_state)
		return self.transitions[self.alphabet.index(input)][current_state] if self.alphabet.index(input)
	end

	def valid_string?(input)
		state = 0
		input.split('').each do |c|
			state = next_state(c, state)
		end
		return self.accepting_states.include?(state)
	end

	def process_inputs(file)
		input_file = FileReader.new(file)
		puts "\n"

		input_file.contents.each_with_index do |test_string, i|
			output = "accept" if self.valid_string?(test_string)
			output ||= "reject"

			puts output
		end
	end

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
