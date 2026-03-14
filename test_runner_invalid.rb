require_relative "roman_numerals_transducer.rb"

invalid_numerals = ["MMMM", "DD", "CCCC", "LL", "XXXX", "VV", "IIII", "MCMC", "XLX", "XCC", "VIVI", "IVI", "IXI", "VIXI", "XIXI"]
invalid_accepted = []
transducer = RomanNumeralTransducer.new("")

invalid_numerals.each do |word|
  transducer.set_word(word)
  result = transducer.start()

  if result != nil
    invalid_accepted.push(word)
  end
end

if invalid_accepted.size == 0
  puts("Teste finalizado. Nenhum algarismo inválido foi aceito")
else
  puts("Teste finalizado. #{invalid_accepted.size} algarismos inválidos foram aceitos:")
  puts(invalid_accepted.join(", "))
end
