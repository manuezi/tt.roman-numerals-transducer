require "roman-numerals"

require_relative "roman_numerals_transducer"

transducer = RomanNumeralTransducer.new("")
errors = 0

(1..3999).each do |expected|
  romano = RomanNumerals.to_roman(expected)
  
  transducer.set_word(romano)
  result = transducer.start() 
  
  if result.sum != expected
    puts "FALHOU: #{romano} | Esperado: #{expected} | Obtido: #{result.sum}"
    errors += 1
  end
end

if errors == 0
  puts "SUCESSO ABSOLUTO: O Autômato converteu todos os 3999 números corretamente! 🚀"
else
  puts "Deu ruim. Tivemos #{errors} erros. Verifique os logs acima."
end
