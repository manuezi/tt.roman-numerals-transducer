require "roman-numerals"

require_relative "roman_numerals_transducer"

transducer = RomanNumeralTransducer.new("")
errors = 0

(1..3999).each do |expected|
  roman = RomanNumerals.to_roman(expected)
  
  transducer.set_word(roman)
  result = transducer.start() 
  
  if result.sum != expected
    puts("FAILED: #{roman} | Expected: #{expected} | Received: #{result.sum}")
    errors += 1
  end
end

if errors == 0
  puts("SUCCESS: Automaton converted all 3999 numbers correctly! 🚀")
else
  puts("Found #{errors} errors. Verify the logs above.")
end
