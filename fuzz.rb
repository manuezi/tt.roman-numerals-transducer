require "set"
require "stringio"
require_relative "afn.rb"
require "roman-numerals"

valid_romans = (1..3999).map { |i| RomanNumerals.to_roman(i) }.to_set
transducer = RomanNumeralTransducer.new("")

symbols = ["I", "V", "X", "L", "C", "D", "M"]
invalid_accepted = []

(1..5).each do |length|
  symbols.repeated_permutation(length).each do |combo|
    word = combo.join("")
    
    # Skip if it's a valid Roman numeral
    next if valid_romans.include?(word)
    
    transducer.set_word(word)
    transducer.instance_variable_set(:@debug_mode, true)
    
    original_stdout = $stdout
    $stdout = StringIO.new
    
    begin
      transducer.start()
      output = $stdout.string
      if output.include?("Aceito")
        invalid_accepted << word
      end
    ensure
      $stdout = original_stdout
    end
  end
end

puts "Fuzzing complete. Found #{invalid_accepted.size} invalid words accepted:"
puts invalid_accepted.join(", ")
